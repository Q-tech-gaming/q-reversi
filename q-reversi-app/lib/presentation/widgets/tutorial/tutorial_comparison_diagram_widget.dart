import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';

/// 比較図ウィジェット（通常コンピュータ vs 量子コンピュータ）
class TutorialComparisonDiagramWidget extends StatelessWidget {
  final Map<String, dynamic>? data;

  const TutorialComparisonDiagramWidget({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 画像の最大サイズを計算（画面幅の40%程度）
        final maxImageSize = (constraints.maxWidth * 0.4).clamp(150.0, 300.0);
        
        return Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 従来コンピュータ
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).tutorialClassicalComputer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxImageSize,
                        maxHeight: maxImageSize,
                      ),
                      child: Image.asset(
                        'assets/PC_img.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('画像読み込みエラー: assets/PC_img.png');
                          debugPrint('エラー: $error');
                          return Container(
                            width: maxImageSize,
                            height: maxImageSize,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.white70,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context).tutorialImageLoadError(
                                      'assets/PC_img.png',
                                      error.toString(),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // 量子コンピュータ
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context).tutorialQuantumComputer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxImageSize,
                        maxHeight: maxImageSize,
                      ),
                      child: Image.asset(
                        'assets/QC_img.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('画像読み込みエラー: assets/QC_img.png');
                          debugPrint('エラー: $error');
                          return Container(
                            width: maxImageSize,
                            height: maxImageSize,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.white70,
                                    size: 48,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context).tutorialImageLoadError(
                                      'assets/QC_img.png',
                                      error.toString(),
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}

