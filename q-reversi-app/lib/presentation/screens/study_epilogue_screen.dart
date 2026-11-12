import 'package:flutter/material.dart';
import '../../core/background_music.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/content/study_content.dart';
import '../widgets/sound_back_button.dart';

/// スタディ「終わりに」— 簡略化の注釈と参考書への誘導（1ページ）
class StudyEpilogueScreen extends StatelessWidget {
  const StudyEpilogueScreen({super.key});

  static const Color _bgTop = Color(0xFF0A0E27);
  static const Color _bgBottom = Color(0xFF1A1F3A);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final content = StudyContent.ofContext(context);
    return BgmScope(
      track: Bgm.study,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            l10n.studyMenuEpilogue,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF1A1F3A),
          foregroundColor: Colors.white,
          leading: const SoundBackButton(),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_bgTop, _bgBottom],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.epilogueLead,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 16,
                      height: 1.65,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle(content.epiloguePhaseTitle),
                  const SizedBox(height: 10),
                  for (final bullet in content.epiloguePhaseBullets)
                    _bullet(content.bulletMark, bullet),
                  const SizedBox(height: 24),
                  _sectionTitle(content.epilogueLearnMoreTitle),
                  const SizedBox(height: 10),
                  Text(
                    content.epilogueLearnMoreBody,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 16,
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _bullet(String mark, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mark,
            style: const TextStyle(
              color: Color(0xFF9C6BFF),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          if (mark != '・') const SizedBox(width: 6),
          Expanded(
            child: Text(
              body,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
