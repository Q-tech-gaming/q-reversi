import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

/// 比較図ウィジェット（通常コンピュータ vs 量子コンピュータ）
class TutorialComparisonDiagramWidget extends StatelessWidget {
  final Map<String, dynamic>? data;

  const TutorialComparisonDiagramWidget({
    super.key,
    this.data,
  });

  static const double _labelHeight = 40;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        // 画像の最大サイズを計算（画面幅の40%程度）
        final maxImageSize = (constraints.maxWidth * 0.4).clamp(150.0, 300.0);

        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ComparisonColumn(
                  label: l10n.tutorialClassicalComputer,
                  imagePath: 'assets/PC_img.png',
                  imageSize: maxImageSize,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ComparisonColumn(
                  label: l10n.tutorialQuantumComputer,
                  imagePath: 'assets/QC_img.png',
                  imageSize: maxImageSize,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ComparisonColumn extends StatelessWidget {
  const _ComparisonColumn({
    required this.label,
    required this.imagePath,
    required this.imageSize,
  });

  final String label;
  final String imagePath;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: TutorialComparisonDiagramWidget._labelHeight,
          width: double.infinity,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: imageSize,
          height: imageSize,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('画像読み込みエラー: $imagePath');
              debugPrint('エラー: $error');
              return Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.error_outline,
                    color: Colors.white.withValues(alpha: 0.7),
                    size: 48,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
