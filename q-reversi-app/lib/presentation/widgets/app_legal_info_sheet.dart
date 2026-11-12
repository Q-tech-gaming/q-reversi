import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/firebase/ranking_data_deletion_service.dart';
import '../../data/firebase/time_attack_run_remote_service.dart';
import '../../l10n/app_localizations.dart';

/// 公開ドキュメント URL（GitHub Pages）
///
/// 表示言語ごとの URL は [AppLocalizations.legalPrivacyPolicyUrl] /
/// [AppLocalizations.legalSupportUrl] を優先して使用する。
abstract final class AppLegalLinks {
  static const privacyPolicy =
      'https://q-tech-gaming.github.io/q-reversi-privacy-policy/';
  static const support = 'https://q-tech-gaming.github.io/support-ja/';

  static Future<bool> open(String url) async {
    final uri = Uri.parse(url);
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// プライバシーポリシー / サポートへの導線
Future<void> showAppLegalInfoSheet(BuildContext context) {
  final parentContext = context;
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: const Color(0xFF1A1F3A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                l10n.helpAndInfo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined,
                    color: Colors.white70),
                title: Text(
                  l10n.legalPrivacyPolicy,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.open_in_new,
                    color: Colors.white38, size: 18),
                onTap: () => _openLink(
                  context,
                  l10n.legalPrivacyPolicyUrl,
                ),
              ),
              ListTile(
                leading:
                    const Icon(Icons.support_agent, color: Colors.white70),
                title: Text(
                  l10n.legalSupport,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: const Icon(Icons.open_in_new,
                    color: Colors.white38, size: 18),
                onTap: () => _openLink(
                  context,
                  l10n.legalSupportUrl,
                ),
              ),
              const Divider(color: Colors.white12),
              ListTile(
                leading: const Icon(Icons.delete_forever_outlined,
                    color: Colors.white38),
                title: Text(
                  l10n.legalDeleteRankingData,
                  style: const TextStyle(color: Colors.white54, fontSize: 14),
                ),
                subtitle: Text(
                  l10n.legalDeleteRankingDataSubtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showRankingDataDeletionDialog(parentContext);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> _openLink(BuildContext context, String url) async {
  final l10n = AppLocalizations.of(context);
  final ok = await AppLegalLinks.open(url);
  if (!ok && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.legalCouldNotOpenPage)),
    );
  }
}

/// ランキング関連データの削除。確認を2回求める。
Future<void> showRankingDataDeletionDialog(BuildContext context) async {
  final first = await showDialog<bool>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        backgroundColor: const Color(0xFF1A1F3A),
        title: Text(
          l10n.legalDeleteDialogTitle,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          l10n.legalDeleteDialogBody,
          style:
              const TextStyle(color: Colors.white70, fontSize: 14, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.continueAction,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
  if (first != true || !context.mounted) return;

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context);
      return AlertDialog(
        backgroundColor: const Color(0xFF1A1F3A),
        title: Text(
          l10n.legalDeleteConfirmTitle,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          l10n.legalDeleteConfirmBody,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.deleteAction,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      );
    },
  );
  if (confirmed != true || !context.mounted) return;

  final l10n = AppLocalizations.of(context);

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF1A1F3A),
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                l10n.legalDeleting,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      );
    },
  );

  String? error;
  try {
    await RankingDataDeletionService().deleteAllRankingData();
  } catch (e) {
    error = e is TimeAttackRunRemoteException
        ? e.message
        : l10n.legalDeleteFailed;
  }
  if (!context.mounted) return;
  Navigator.of(context).pop();

  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF1A1F3A),
        title: Text(
          error == null ? l10n.legalDeleteDoneTitle : l10n.legalDeleteFailedTitle,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          error ?? l10n.legalDeleteDoneMessage,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
          ),
        ],
      );
    },
  );
}
