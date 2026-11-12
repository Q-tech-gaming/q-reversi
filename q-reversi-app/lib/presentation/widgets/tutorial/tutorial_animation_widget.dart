import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import 'tutorial_operation_demo_animation.dart';
import 'tutorial_measurement_animation.dart';
import 'tutorial_swap_animation.dart';
import 'tutorial_cnot_gray_animation.dart';
import 'tutorial_coin_flip_animation.dart';
import 'tutorial_entanglement_animation.dart';

/// アニメーションウィジェット
class TutorialAnimationWidget extends StatelessWidget {
  final Map<String, dynamic>? data;

  const TutorialAnimationWidget({
    super.key,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    final animationType = data?['type'] as String?;

    switch (animationType) {
      case 'operation_demo':
        return const TutorialOperationDemoAnimation();
      case 'measurement':
      case 'measurement_probability':
        return TutorialMeasurementAnimation(
          showProbability: animationType == 'measurement_probability',
        );
      case 'coin_flip':
        return const TutorialCoinFlipAnimation();
      case 'swap':
        return const TutorialSwapAnimation();
      case 'cnot_gray':
        return const TutorialCnotGrayAnimation();
      case 'entanglement':
        return const TutorialEntanglementAnimation();
      default:
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context).tutorialAnimationLabel,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        );
    }
  }
}

