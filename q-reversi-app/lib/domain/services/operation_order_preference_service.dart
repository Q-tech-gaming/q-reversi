import 'package:shared_preferences/shared_preferences.dart';

/// 操作設定の現在値
class OperationOrderSettings {
  const OperationOrderSettings({
    required this.allowFreeSelectionOrder,
    required this.doubleTapApplyEnabled,
  });

  /// ゲートとマスを好きな順で選べるか
  final bool allowFreeSelectionOrder;

  /// ゲート選択後、駒のダブルタップや行・列の再クリックでゲートをすぐ適用するか
  final bool doubleTapApplyEnabled;
}

/// ゲート／盤面の操作順設定
///
/// デフォルトはゲート先行。`allowFreeSelectionOrder` が true のとき順不同。
/// ダブルタップ即適用はデフォルトオフで、既存の「選択してから適用ボタン」は変わらない。
class OperationOrderPreferenceService {
  static const String _freeSelectionOrderKey = 'allow_free_selection_order';
  static const String _doubleTapApplyKey = 'double_tap_apply_gate';

  /// ゲートとマスを好きな順で選べるか（デフォルト: false = ゲート先行）
  Future<bool> isFreeSelectionOrderEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_freeSelectionOrderKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setFreeSelectionOrderEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_freeSelectionOrderKey, enabled);
    } catch (_) {
      // 保存失敗は致命的ではない
    }
  }

  /// ゲート選択後のダブルタップ即適用（デフォルト: false）
  Future<bool> isDoubleTapApplyEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_doubleTapApplyKey) ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> setDoubleTapApplyEnabled(bool enabled) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_doubleTapApplyKey, enabled);
    } catch (_) {
      // 保存失敗は致命的ではない
    }
  }
}
