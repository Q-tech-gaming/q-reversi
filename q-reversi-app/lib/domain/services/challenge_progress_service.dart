import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../entities/challenge_progress.dart';
import 'tutorial_progress_service.dart';

/// チャレンジ進捗管理サービス
class ChallengeProgressService {
  static const String _progressKey = 'challenge_progress';

  /// 進捗を読み込む
  Future<ChallengeProgressManager> loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // 直前の setString 直後にキャッシュだけが古いままになる端末対策
      try {
        await prefs.reload();
      } catch (_) {}
      final progressJson = prefs.getString(_progressKey);
      
      if (progressJson == null) {
        return ChallengeProgressManager(
          {},
          tutorialCompleted: await _isTutorialFinishedOrSkipped(),
        );
      }

      final Map<String, dynamic> decoded = json.decode(progressJson);
      final Map<int, ChallengeProgress> progress = {};
      
      decoded.forEach((key, value) {
        final level = int.tryParse(key);
        if (level != null) {
          progress[level] = ChallengeProgress(
            level: level,
            isCompleted: value['isCompleted'] ?? false,
            stars: value['stars'] ?? 0,
            turnsUsed: value['turnsUsed'] ?? 0,
          );
        }
      });

      return ChallengeProgressManager(
        progress,
        tutorialCompleted: await _isTutorialFinishedOrSkipped(),
      );
    } catch (e) {
      return ChallengeProgressManager({});
    }
  }

  /// 最後まで終えた場合も、途中の×で抜けた場合も全開放する。
  Future<bool> _isTutorialFinishedOrSkipped() {
    return TutorialProgressService().isTutorialCompletedOrSkipped();
  }

  /// 進捗を保存
  Future<void> saveProgress(ChallengeProgressManager manager) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final progress = manager.allProgress;
      
      final Map<String, dynamic> encoded = {};
      progress.forEach((level, progressData) {
        encoded[level.toString()] = {
          'isCompleted': progressData.isCompleted,
          'stars': progressData.stars,
          'turnsUsed': progressData.turnsUsed,
        };
      });

      await prefs.setString(_progressKey, json.encode(encoded));
    } catch (e) {
      // エラーは無視（進捗保存の失敗は致命的ではない）
    }
  }

  /// レベルをクリア（保存直前に必ずストレージから再読込し、他レベルの記録を消さない）
  Future<ChallengeProgressManager> completeLevel(
    int level,
    int turnsUsed,
    int optimalTurns,
  ) async {
    final latest = await loadProgress();
    final currentProgress = latest.allProgress[level];
    final stars = _calculateStars(turnsUsed, optimalTurns);

    final newProgress = ChallengeProgress(
      level: level,
      isCompleted: true,
      stars: stars,
      turnsUsed: turnsUsed,
    );

    // 既存の進捗より良い場合のみ更新
    if (currentProgress == null ||
        !currentProgress.isCompleted ||
        stars > currentProgress.stars) {
      final updatedManager = latest.updateProgress(newProgress);
      await saveProgress(updatedManager);
      return updatedManager;
    }

    return latest;
  }

  /// スター数を計算
  int _calculateStars(int turnsUsed, int optimalTurns) {
    if (turnsUsed <= optimalTurns) {
      return 3; // 最短ターンでクリア → 星3つ
    } else if (turnsUsed <= optimalTurns * 3) {
      return 2; // 最短ターンの3倍以内でクリア → 星2つ
    } else {
      return 1; // 3倍を超えたら → 星1つ
    }
  }
}



