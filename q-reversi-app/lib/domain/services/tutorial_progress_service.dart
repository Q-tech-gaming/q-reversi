import 'package:shared_preferences/shared_preferences.dart';

/// チュートリアル進捗管理サービス
class TutorialProgressService {
  static const String _tutorialCompletedKey = 'tutorial_completed';
  static const String _tutorialSkippedKey = 'tutorial_skipped';

  /// チュートリアルを最後まで終えたか（スキップは含まない）
  Future<bool> isTutorialCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_tutorialCompletedKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  /// チュートリアルが完了またはスキップされているか確認
  Future<bool> isTutorialCompletedOrSkipped() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final completed = prefs.getBool(_tutorialCompletedKey) ?? false;
      final skipped = prefs.getBool(_tutorialSkippedKey) ?? false;
      return completed || skipped;
    } catch (e) {
      return false;
    }
  }

  /// チュートリアル完了をマーク
  Future<void> markTutorialCompleted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_tutorialCompletedKey, true);
    } catch (e) {
      // エラーは無視（進捗保存の失敗は致命的ではない）
    }
  }

  /// チュートリアルスキップをマーク
  Future<void> markTutorialSkipped() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_tutorialSkippedKey, true);
    } catch (e) {
      // エラーは無視（進捗保存の失敗は致命的ではない）
    }
  }

  /// チュートリアル進捗をリセット（デバッグ用）
  Future<void> resetTutorialProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tutorialCompletedKey);
      await prefs.remove(_tutorialSkippedKey);
    } catch (e) {
      // エラーは無視
    }
  }
}
