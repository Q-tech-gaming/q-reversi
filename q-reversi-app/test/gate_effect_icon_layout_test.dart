import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:q_reversi_app/domain/entities/game_mode.dart';
import 'package:q_reversi_app/domain/entities/gate_type.dart';
import 'package:q_reversi_app/presentation/widgets/gate_button.dart';
import 'package:q_reversi_app/presentation/widgets/gate_button_grid.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget child) {
    return tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(child: child),
        ),
      ),
    );
  }

  testWidgets('効果アイコン付きゲートボタンが幅の中に収まる', (tester) async {
    await pump(
      tester,
      SizedBox(
        width: 340,
        child: GateButtonGrid(
          showEffectIcon: true,
          rows: const [
            [GateType.h, GateType.x],
            [GateType.y, GateType.z],
            [GateType.cnot, GateType.swap],
          ],
          itemBuilder: (gate) => GateButton(
            gate: gate,
            showEffectIcon: true,
            playerColor: gate == GateType.cnot ? PlayerColor.black : null,
            isVsMode: true,
          ),
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('CNOT'), findsOneWidget);
    expect(find.text('SWAP'), findsOneWidget);
  });

  testWidgets('VSの狭い列でもアイコン付きボタンが例外を出さない', (tester) async {
    await pump(
      tester,
      SizedBox(
        width: 210,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GateButtonGrid(
                showEffectIcon: true,
                rows: [
                  [GateType.h, GateType.x],
                  [GateType.cnot, GateType.swap],
                ],
                itemBuilder: _vsBlackCnot,
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 84,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.topCenter,
                child: Column(
                children: [
                  GateButton(gate: GateType.cnot, compact: true, cooldown: 3),
                  GateButton(gate: GateType.swap, compact: true),
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('アイコンなしは従来の文字ボタン', (tester) async {
    await pump(
      tester,
      GateButtonGrid(
        showEffectIcon: false,
        rows: const [
          [GateType.x, GateType.h],
        ],
        itemBuilder: (gate) => GateButton(gate: gate),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('X'), findsOneWidget);
    expect(find.text('H'), findsOneWidget);
  });
}

Widget _vsBlackCnot(GateType gate) {
  return GateButton(
    gate: gate,
    showEffectIcon: true,
    playerColor: PlayerColor.black,
    isVsMode: true,
  );
}
