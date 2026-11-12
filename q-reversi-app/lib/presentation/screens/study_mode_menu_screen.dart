import 'package:flutter/material.dart';
import '../../core/sound_effects.dart';
import '../../domain/entities/game_mode.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/sound_back_button.dart';
import 'study_quantum_intro_screen.dart';
import 'study_one_cell_quantum_screen.dart';
import 'study_two_cell_quantum_screen.dart';
import 'study_three_cell_grover_screen.dart';
import 'study_epilogue_screen.dart';

/// スタディモード: 学習コンテンツ一覧
class StudyModeMenuScreen extends StatelessWidget {
  const StudyModeMenuScreen({super.key});

  static List<_StudyMenuItem> _buildItems(AppLocalizations l10n) => [
    _StudyMenuItem(
      mode: StudyMode.intro,
      title: l10n.studyMenuIntro,
      icon: Icons.lightbulb_outline,
    ),
    _StudyMenuItem(
      mode: StudyMode.study1,
      title: l10n.studyMenuOneCell,
      icon: Icons.looks_one,
    ),
    _StudyMenuItem(
      mode: StudyMode.study2,
      title: l10n.studyMenuTwoCell,
      icon: Icons.looks_two,
    ),
    _StudyMenuItem(
      mode: StudyMode.study3,
      title: l10n.studyMenuThreeCell,
      icon: Icons.auto_graph,
    ),
    _StudyMenuItem(
      mode: StudyMode.epilogue,
      title: l10n.studyMenuEpilogue,
      icon: Icons.menu_book,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _buildItems(l10n);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.studyMenuTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1F3A),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: const SoundBackButton(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E27),
              Color(0xFF1A1F3A),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return _StudyMenuCard(
                item: item,
                onTap: () async {
                  await SoundEffects.instance.untilSelectPlaying();
                  if (!context.mounted) return;
                  if (item.mode == StudyMode.intro) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyQuantumIntroScreen(),
                      ),
                    );
                    return;
                  }
                  if (item.mode == StudyMode.study1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyOneCellQuantumScreen(),
                      ),
                    );
                    return;
                  }
                  if (item.mode == StudyMode.study2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyTwoCellQuantumScreen(),
                      ),
                    );
                    return;
                  }
                  if (item.mode == StudyMode.study3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyThreeCellGroverScreen(),
                      ),
                    );
                    return;
                  }
                  if (item.mode == StudyMode.epilogue) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudyEpilogueScreen(),
                      ),
                    );
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.studyNavigationFailed),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StudyMenuItem {
  const _StudyMenuItem({
    required this.mode,
    required this.title,
    required this.icon,
  });

  final StudyMode mode;
  final String title;
  final IconData icon;
}

class _StudyMenuCard extends StatelessWidget {
  const _StudyMenuCard({
    required this.item,
    required this.onTap,
  });

  final _StudyMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1F3A).withValues(alpha: 0.85),
      child: ListTile(
        leading: Icon(
          item.icon,
          size: 32,
          color: const Color(0xFF6B46C1),
        ),
        title: Text(
          item.title,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.white70,
        ),
        onTap: onTap,
      ),
    );
  }
}
