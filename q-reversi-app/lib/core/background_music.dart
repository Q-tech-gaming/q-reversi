import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

import '../domain/services/audio_volume_preference_service.dart';

/// 画面に応じてループ再生する BGM。
///
/// タイトル画面では鳴らさない。モード選択に入ってから [Bgm.home]。
/// 各画面が自分の曲を重ね、閉じたら下の曲に戻る。
/// ホームは止めた位置から再開する。フリーランだけ頭から鳴らし直す。
class BackgroundMusic with WidgetsBindingObserver {
  BackgroundMusic._();

  static final BackgroundMusic instance = BackgroundMusic._();

  static const _baseId = 0;

  final Map<Bgm, AudioPlayer> _players = {};
  final List<_BgmClaim> _stack = [];
  final Set<int> _restarted = {};

  int _nextId = 1;
  int _epoch = 0;
  bool _applyQueued = false;
  bool _ready = false;
  bool _observing = false;
  bool _inBackground = false;
  Bgm? _active;
  int? _activeClaimId;
  double _volume = AudioVolumePreferenceService.defaultBgm;
  Timer? _homeFadeTimer;
  int _homeFadeToken = 0;
  bool _fadingHome = false;
  double _homeFadeProgress = 1;

  static const _homeFadeIn = Duration(milliseconds: 2000);

  Future<void> prepare() async {
    if (_ready) return;
    _volume = await AudioVolumePreferenceService().bgmVolume();

    try {
      await AudioPlayer.global.setAudioContext(
        AudioContext(
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.playback,
            options: const {AVAudioSessionOptions.mixWithOthers},
          ),
          android: const AudioContextAndroid(
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.game,
            audioFocus: AndroidAudioFocus.gain,
          ),
        ),
      );
    } catch (e) {
      debugPrint('BGM の AudioContext 設定に失敗しました: $e');
    }

    final context = AudioContext(
      android: const AudioContextAndroid(
        contentType: AndroidContentType.music,
        usageType: AndroidUsageType.game,
        audioFocus: AndroidAudioFocus.gain,
      ),
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.playback,
        options: const {AVAudioSessionOptions.mixWithOthers},
      ),
    );

    try {
      for (final track in Bgm.values) {
        final player = AudioPlayer();
        await player.setAudioContext(context);
        await player.setReleaseMode(ReleaseMode.loop);
        await player.setVolume(_volume);
        await player.setSource(AssetSource(track.path));
        _players[track] = player;
      }
      _ready = true;
      if (!_observing) {
        WidgetsBinding.instance.addObserver(this);
        _observing = true;
      }
    } catch (e) {
      debugPrint('BGM の準備に失敗しました: $e');
    }
  }

  int acquire() => _nextId++;

  void hold(int id, Bgm track, {bool restart = false}) {
    _stack.removeWhere((claim) => claim.id == id);
    _stack.add(_BgmClaim(id, track, restart));
    _schedule();
  }

  /// 再生中の曲も含めて、BGM 全体の音量を変える。
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
    for (final entry in _players.entries) {
      final level = _fadingHome && entry.key == Bgm.home
          ? _volume * _homeFadeProgress
          : _volume;
      unawaited(entry.value.setVolume(level));
    }
  }

  void release(int id) {
    if (id == _baseId) return;
    _stack.removeWhere((claim) => claim.id == id);
    _restarted.remove(id);
    if (_activeClaimId == id) _activeClaimId = null;
    _schedule();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _inBackground = false;
      _schedule();
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _inBackground = true;
      final player = _active == null ? null : _players[_active!];
      if (player != null) unawaited(player.pause());
    }
  }

  void _schedule() {
    _epoch++;
    if (_applyQueued) return;
    _applyQueued = true;
    // 次の画面の initState が乗ってから決める。先に止めると、同じ曲が頭から鳴り直す。
    WidgetsBinding.instance.scheduleFrame();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyQueued = false;
      final seen = _epoch;
      unawaited(_apply(seen));
    });
  }

  Future<void> _apply(int seen) async {
    if (!_ready) return;
    if (_stack.isEmpty) {
      if (_active != null) {
        try {
          await _players[_active!]?.pause();
        } catch (e) {
          debugPrint('BGM の停止に失敗しました: $e');
        }
        _active = null;
        _activeClaimId = null;
      }
      if (seen != _epoch) _schedule();
      return;
    }
    final top = _stack.last;
    final player = _players[top.track];
    if (player == null) return;

    final restartThisClaim = top.restart && !_restarted.contains(top.id);
    if (_active == top.track && !restartThisClaim) {
      // 次のレベルへ進むときなど、同じ曲がそのまま続く。
      // 再生し直すと端末によっては頭に戻る。
      _activeClaimId = top.id;
      if (seen != _epoch) _schedule();
      return;
    }

    try {
      final switching = _active != top.track;
      if (switching && _active == Bgm.home) {
        _endHomeFade();
        await _players[Bgm.home]?.setVolume(_volume);
      }
      if (switching && _active != null) {
        await _players[_active!]?.pause();
      }
      if (seen != _epoch) {
        _schedule();
        return;
      }

      if (restartThisClaim) {
        _restarted.add(top.id);
        await player.seek(Duration.zero);
      } else if (switching && top.track != Bgm.home) {
        await player.seek(Duration.zero);
      }
      if (seen != _epoch) {
        _schedule();
        return;
      }

      _active = top.track;
      _activeClaimId = top.id;
      final fadeHome = !_inBackground &&
          top.track == Bgm.home &&
          (restartThisClaim || await _homeIsAtStart(player));
      if (fadeHome) {
        await _fadeInHome(player);
      } else if (top.track == Bgm.home) {
        _endHomeFade();
        await player.setVolume(_volume);
      }
      if (_inBackground) {
        await player.pause();
      } else if (player.state != PlayerState.playing) {
        await player.resume();
      }
    } catch (e) {
      debugPrint('BGM の再生に失敗しました: $e');
    }

    if (seen != _epoch) _schedule();
  }

  Future<bool> _homeIsAtStart(AudioPlayer player) async {
    try {
      final position = await player.getCurrentPosition();
      return position == null || position <= const Duration(milliseconds: 300);
    } catch (_) {
      return true;
    }
  }

  Future<void> _fadeInHome(AudioPlayer player) async {
    _homeFadeToken++;
    final token = _homeFadeToken;
    _homeFadeTimer?.cancel();
    _fadingHome = true;
    _homeFadeProgress = 0;
    await player.setVolume(0);

    const steps = 24;
    final step = _homeFadeIn ~/ steps;
    var i = 0;
    _homeFadeTimer = Timer.periodic(step, (timer) {
      if (token != _homeFadeToken) {
        timer.cancel();
        return;
      }
      i++;
      final t = (i / steps).clamp(0.0, 1.0);
      _homeFadeProgress = Curves.easeOut.transform(t);
      unawaited(player.setVolume(_volume * _homeFadeProgress));
      if (i >= steps) {
        _fadingHome = false;
        _homeFadeProgress = 1;
        timer.cancel();
        _homeFadeTimer = null;
        unawaited(player.setVolume(_volume));
      }
    });
  }

  void _endHomeFade() {
    _homeFadeToken++;
    _homeFadeTimer?.cancel();
    _homeFadeTimer = null;
    _fadingHome = false;
    _homeFadeProgress = 1;
  }
}

class BgmHandle {
  BgmHandle._(this.id);

  final int id;

  static BgmHandle hold(Bgm track, {bool restart = false}) {
    final id = BackgroundMusic.instance.acquire();
    BackgroundMusic.instance.hold(id, track, restart: restart);
    return BgmHandle._(id);
  }

  void release() => BackgroundMusic.instance.release(id);
}

/// 表示中だけ [track] を鳴らし、破棄で元の曲に戻す。
class BgmScope extends StatefulWidget {
  const BgmScope({
    super.key,
    required this.track,
    this.restart = false,
    required this.child,
  });

  final Bgm track;
  final bool restart;
  final Widget child;

  @override
  State<BgmScope> createState() => _BgmScopeState();
}

class _BgmScopeState extends State<BgmScope> {
  late final BgmHandle _handle;

  @override
  void initState() {
    super.initState();
    _handle = BgmHandle.hold(widget.track, restart: widget.restart);
  }

  @override
  void dispose() {
    _handle.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

enum Bgm {
  home('sounds/bgm/home_bgm.mp3'),
  study('sounds/bgm/study.mp3'),
  challenge('sounds/bgm/challenge.mp3'),
  timeAttack('sounds/bgm/TimeAttack.mp3'),
  vs('sounds/bgm/VSMode.mp3');

  const Bgm(this.path);

  /// `assets/` からの相対パス。
  final String path;
}

class _BgmClaim {
  const _BgmClaim(this.id, this.track, this.restart);

  final int id;
  final Bgm track;
  final bool restart;
}
