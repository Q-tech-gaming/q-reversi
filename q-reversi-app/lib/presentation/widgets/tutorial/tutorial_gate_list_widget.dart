import 'package:flutter/material.dart';
import '../../../domain/entities/gate_type.dart';
import '../../gate_effect_icon_setting.dart';
import '../gate_button.dart';
import '../gate_button_grid.dart';

/// ゲート一覧ウィジェット
class TutorialGateListWidget extends StatelessWidget {
  const TutorialGateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ValueListenableBuilder<bool>(
        valueListenable: GateEffectIconSetting.instance.notifier,
        builder: (context, showIcons, _) {
          final gates = GateType.values;
          final rows = showIcons
              ? chunkGateRows(gates, 2)
              : [gates];
          return GateButtonGrid(
            rows: rows,
            showEffectIcon: showIcons,
            itemBuilder: (gate) => GateButton(
              gate: gate,
              isEnabled: false,
              isReadOnly: true,
              showEffectIcon: showIcons,
            ),
          );
        },
      ),
    );
  }
}


