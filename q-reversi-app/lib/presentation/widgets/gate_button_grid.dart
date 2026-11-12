import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/entities/gate_type.dart';

/// ゲートボタンを行に並べる。効果アイコンを出すときは、はみ出さず収まる幅まで縮める。
class GateButtonGrid extends StatelessWidget {
  final List<List<GateType>> rows;
  final bool showEffectIcon;
  final Widget Function(GateType gate) itemBuilder;

  const GateButtonGrid({
    super.key,
    required this.rows,
    required this.showEffectIcon,
    required this.itemBuilder,
  });

  /// アイコンを原寸で収めたいボタン幅。
  static double preferredWidth(GateType gate, {required bool showEffectIcon}) {
    if (!showEffectIcon) return 60;
    switch (gate) {
      case GateType.cnot:
      case GateType.swap:
        return 176;
      case GateType.h:
      case GateType.y:
      case GateType.x:
      case GateType.z:
        return 124;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              _buildRow(rows[i], constraints.maxWidth),
            ],
          ],
        );
      },
    );
  }

  Widget _buildRow(List<GateType> gates, double maxWidth) {
    const gap = 8.0;
    if (!showEffectIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < gates.length; i++) ...[
            if (i > 0) const SizedBox(width: gap),
            SizedBox(width: 60, child: itemBuilder(gates[i])),
          ],
        ],
      );
    }

    final preferred = gates
        .map((gate) => preferredWidth(gate, showEffectIcon: true))
        .reduce(math.max);
    final gaps = gap * (gates.length - 1);
    final available =
        maxWidth.isFinite ? (maxWidth - gaps) / gates.length : preferred;
    final width = !available.isFinite || available <= 0
        ? preferred
        : math.min(preferred, available);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < gates.length; i++) ...[
          if (i > 0) const SizedBox(width: gap),
          SizedBox(
            width: width,
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: itemBuilder(gates[i]),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// ゲートを [size] 個ずつの行に分ける。
List<List<GateType>> chunkGateRows(List<GateType> gates, int size) {
  if (gates.isEmpty || size <= 0) return const [];
  final rows = <List<GateType>>[];
  for (var i = 0; i < gates.length; i += size) {
    final end = math.min(i + size, gates.length);
    rows.add(gates.sublist(i, end));
  }
  return rows;
}
