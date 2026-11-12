import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../piece_widget.dart';
import '../../../domain/entities/piece.dart';
import '../../../domain/entities/piece_type.dart';
import '../../../domain/entities/position.dart';

/// エンタングルメントアニメーション
class TutorialEntanglementAnimation extends StatefulWidget {
  const TutorialEntanglementAnimation({super.key});

  @override
  State<TutorialEntanglementAnimation> createState() =>
      _TutorialEntanglementAnimationState();
}

class _TutorialEntanglementAnimationState
    extends State<TutorialEntanglementAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  int _patternIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _patternIndex = (_patternIndex + 1) % 2;
        });
        _controller.reset();
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // パターン1: 白+白、パターン2: 黒+黒
    final controlType = _patternIndex == 0 ? PieceType.white : PieceType.black;
    final targetType = _patternIndex == 0 ? PieceType.white : PieceType.black;

    return Container(
      padding: const EdgeInsets.all(16),
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50), // 緑色の盤面背景
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFF4CAF50), // 緑色の枠線
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: PieceWidget(
                              piece: Piece(
                                id: 'c1',
                                type: controlType,
                                position: const Position(0, 0),
                              ),
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 32),
                  Container(
                    width: 2,
                    height: 40,
                    color: Color.lerp(
                      const Color(0xFFEC4899),
                      Colors.white,
                      _pulseAnimation.value,
                    ),
                  ),
                  const SizedBox(width: 32),
                  Column(
                    children: [
                      const Text(
                        'T',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      Transform.scale(
                        scale: _pulseAnimation.value,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50), // 緑色の盤面背景
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFF4CAF50), // 緑色の枠線
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: PieceWidget(
                              piece: Piece(
                                id: 't1',
                                type: targetType,
                                position: const Position(0, 0),
                              ),
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _patternIndex == 0
                    ? AppLocalizations.of(context)
                        .tutorialEntanglementResultWhite
                    : AppLocalizations.of(context)
                        .tutorialEntanglementResultBlack,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

