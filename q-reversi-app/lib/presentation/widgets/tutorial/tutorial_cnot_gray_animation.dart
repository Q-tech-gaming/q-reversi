import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../piece_widget.dart';
import '../../../domain/entities/piece.dart';
import '../../../domain/entities/piece_type.dart';
import '../../../domain/entities/position.dart';

/// CNOTゲート（グレー制御）アニメーション
class TutorialCnotGrayAnimation extends StatelessWidget {
  const TutorialCnotGrayAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  Container(
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
                    child: const Center(
                      child: PieceWidget(
                        piece: Piece(
                          id: 'c1',
                          type: PieceType.grayPlus,
                          position: Position(0, 0),
                        ),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  const Text(
                    'T',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  Container(
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
                    child: const Center(
                      child: PieceWidget(
                        piece: Piece(
                          id: 't1',
                          type: PieceType.white,
                          position: Position(0, 0),
                        ),
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6B46C1).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF6B46C1),
                width: 2,
              ),
            ),
            child: const Text(
              'CNOT',
              style: TextStyle(
                color: Color(0xFF6B46C1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).tutorialCnotGrayControlNote,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

