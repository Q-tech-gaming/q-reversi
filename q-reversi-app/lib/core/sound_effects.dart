import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../domain/services/audio_volume_preference_service.dart';

/// 短い効果音。同じ音を連打したときは、直前の再生を止めて頭から鳴らす。
class SoundEffects {
  SoundEffects._();

  static final SoundEffects instance = SoundEffects._();

  final Map<_Sfx, AudioPlayer> _players = {};
  final Map<_Sfx, int> _playToken = {};
  final Map<_Sfx, Future<void>> _queue = {};
  double _volume = AudioVolumePreferenceService.defaultSfx;

  Future<void> prepare() async {
    if (_players.isNotEmpty) return;
    _volume = await AudioVolumePreferenceService().sfxVolume();

    try {
      await AudioPlayer.global.setAudioContext(
        AudioContext(
          android: const AudioContextAndroid(
            contentType: AndroidContentType.sonification,
            usageType: AndroidUsageType.game,
            audioFocus: AndroidAudioFocus.none,
          ),
          iOS: AudioContextIOS(
            category: AVAudioSessionCategory.ambient,
            options: const {AVAudioSessionOptions.mixWithOthers},
          ),
        ),
      );
    } catch (e) {
      debugPrint('AudioContext の設定に失敗しました: $e');
    }

    for (final sfx in _Sfx.values) {
      final player = AudioPlayer();
      await player.setReleaseMode(ReleaseMode.stop);
      await player.setVolume(_volume);
      await player.setSource(AssetSource(sfx.path));
      _players[sfx] = player;
    }
  }

  void start() => unawaited(_startPlayback(_Sfx.start));

  /// 再生が始まってから返す。画面遷移の前に待つ。
  Future<void> untilStartPlaying() => _startPlayback(_Sfx.start);

  void select() => unawaited(_startPlayback(_Sfx.select));

  /// 再生が始まってから返す。画面遷移の前に待つ。
  Future<void> untilSelectPlaying() => _startPlayback(_Sfx.select);

  void reverse() => unawaited(_startPlayback(_Sfx.reverse));

  /// 再生が始まってから返す。画面遷移の前に待つ。
  Future<void> untilReversePlaying() => _startPlayback(_Sfx.reverse);

  void click() => unawaited(_startPlayback(_Sfx.click));

  /// 再生が始まってから返す。画面遷移の前に待つ。
  Future<void> untilClickPlaying() => _startPlayback(_Sfx.click);

  void gateSelect() => unawaited(_startPlayback(_Sfx.gateSelect));

  /// マス・行・列の選択も、ゲート選択と同じ音にする。
  void cellSelect() => unawaited(_startPlayback(_Sfx.gateSelect));

  void apply() => unawaited(_startPlayback(_Sfx.apply));

  void challengeThreeStar() =>
      unawaited(_startPlayback(_Sfx.challengeThreeStar));

  void challengeClear() => unawaited(_startPlayback(_Sfx.challengeClear));

  void timeAttackFinish() => unawaited(_startPlayback(_Sfx.timeAttackFinish));

  void bestScore() => unawaited(_startPlayback(_Sfx.bestScore));

  void vsWin() => unawaited(_startPlayback(_Sfx.vsWin));

  void vsLose() => unawaited(_startPlayback(_Sfx.vsLose));

  /// 効果音全体の音量を変える。
  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
    for (final player in _players.values) {
      unawaited(player.setVolume(_volume));
    }
  }

  /// 頭から再生し、実際に鳴り始めてから返す。
  ///
  /// 再生中に seek してから resume すると、位置戻しと再生開始が両方音を出す。
  /// いったん止めてから、新しい操作だけを1回鳴らす。
  Future<void> _startPlayback(_Sfx sfx) {
    final player = _players[sfx];
    if (player == null) return Future<void>.value();
    final token = (_playToken[sfx] ?? 0) + 1;
    _playToken[sfx] = token;

    final previous = _queue[sfx] ?? Future<void>.value();
    final next = previous.catchError((Object _) {}).then((_) async {
      if (_playToken[sfx] != token) return;
      await _playOnce(player, sfx, token);
    });
    _queue[sfx] = next;
    return next;
  }

  Future<void> _playOnce(AudioPlayer player, _Sfx sfx, int token) async {
    final playing = Completer<void>();
    final subscription = player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.playing && !playing.isCompleted) {
        playing.complete();
      }
    });
    try {
      if (player.state == PlayerState.playing) {
        await player.pause();
      }
      if (_playToken[sfx] != token) return;
      await player.seek(Duration.zero);
      if (_playToken[sfx] != token) return;
      await player.resume();
      if (_playToken[sfx] != token) return;
      await playing.future.timeout(const Duration(milliseconds: 400));
    } catch (e) {
      debugPrint('効果音の再生に失敗しました: $e');
    } finally {
      await subscription.cancel();
    }
  }
}

enum _Sfx {
  start('sounds/sfx/START_soft.mp3'),
  select('sounds/sfx/select.mp3'),
  reverse('sounds/sfx/reverse.mp3'),
  click('sounds/sfx/click.mp3'),
  gateSelect('sounds/sfx/gate_select.mp3'),
  apply('sounds/sfx/apply.mp3'),
  challengeThreeStar('sounds/sfx/challange_3star.mp3'),
  challengeClear('sounds/sfx/challange_clear.mp3'),
  timeAttackFinish('sounds/sfx/timeAttack_finish.mp3'),
  bestScore('sounds/sfx/best_score.mp3'),
  vsWin('sounds/sfx/VS_win.mp3'),
  vsLose('sounds/sfx/VS_lose.mp3');

  const _Sfx(this.path);

  /// `assets/` からの相対パス。
  final String path;
}
