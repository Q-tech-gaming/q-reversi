import 'package:shared_preferences/shared_preferences.dart';

/// BGM と効果音の音量。どちらも 0.0〜1.0。
class AudioVolumePreferenceService {
  static const bgmKey = 'bgm_volume_v2';
  static const sfxKey = 'sfx_volume';

  /// 設定画面の 100%。実際の出力は、この値の 50%（home_bgm はその半分）。
  static const defaultBgm = 1.0;
  static const defaultSfx = 1.0;

  Future<double> bgmVolume() async => _read(bgmKey, defaultBgm);

  Future<double> sfxVolume() async => _read(sfxKey, defaultSfx);

  Future<void> setBgmVolume(double volume) => _write(bgmKey, volume);

  Future<void> setSfxVolume(double volume) => _write(sfxKey, volume);

  Future<double> _read(String key, double fallback) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return (prefs.getDouble(key) ?? fallback).clamp(0.0, 1.0);
    } catch (_) {
      return fallback;
    }
  }

  Future<void> _write(String key, double volume) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(key, volume.clamp(0.0, 1.0));
    } catch (_) {
      // 保存失敗は致命的ではない
    }
  }
}
