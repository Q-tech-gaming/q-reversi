import '../domain/entities/challenge_level.dart';
import '../l10n/app_localizations.dart';

/// [VictoryCondition] の表示名をロケールに合わせて返す（domain の displayName は使わない）。
extension VictoryConditionL10n on VictoryCondition {
  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case VictoryCondition.allWhite:
        return l10n.victoryAllWhite;
      case VictoryCondition.allBlack:
        return l10n.victoryAllBlack;
    }
  }
}
