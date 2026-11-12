import 'package:flutter_test/flutter_test.dart';
import 'package:q_reversi_app/domain/entities/game_mode.dart';
import 'package:q_reversi_app/domain/rules/cnot_control_color.dart';

void main() {
  test('通常モードは自分の色が制御になる', () {
    expect(
      cnotControlIsBlack(playerColor: PlayerColor.black),
      isTrue,
    );
    expect(
      cnotControlIsBlack(playerColor: PlayerColor.white),
      isFalse,
    );
  });

  test('VSモードは相手の色が制御になる', () {
    expect(
      cnotControlIsBlack(playerColor: PlayerColor.white, isVsMode: true),
      isTrue,
    );
    expect(
      cnotControlIsBlack(playerColor: PlayerColor.black, isVsMode: true),
      isFalse,
    );
  });

  test('色が無いときは説明と同じく黒が制御', () {
    expect(cnotControlIsBlack(), isTrue);
    expect(cnotControlIsBlack(isVsMode: true), isTrue);
  });
}
