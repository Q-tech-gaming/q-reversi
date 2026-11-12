import 'package:flutter_test/flutter_test.dart';
import 'package:q_reversi_app/domain/entities/gate_type.dart';
import 'package:q_reversi_app/domain/entities/position.dart';
import 'package:q_reversi_app/presentation/tutorial/interactive_tutorial_script.dart';

void main() {
  test('スクリプトどおりに適用すると各課題が白か黒でそろう', () {
    GateType? gate;
    List<Position> selected = [];

    for (final puzzle in interactiveTutorialPuzzles) {
      var board = puzzle.buildBoard();
      selected = [];
      if (puzzle.actions.first.input == TutorialInput.gate) {
        gate = null;
      }

      for (var i = 0; i < puzzle.actions.length; i++) {
        final action = puzzle.actions[i];
        switch (action.input) {
          case TutorialInput.gate:
            gate = action.gate;
            if (gate!.isTwoBitGate) selected = [];
          case TutorialInput.cell:
            selected = _selectCell(gate!, selected, action.row, action.col);
          case TutorialInput.row:
            selected = tutorialRow(action.row);
          case TutorialInput.column:
            selected = tutorialColumn(action.col);
          case TutorialInput.apply:
            final next = applyTutorialGate(board, gate!, selected);
            expect(
              tutorialBoardsEqual(board, next),
              action.noChange,
              reason: '${puzzle.topic.name} action $i',
            );
            board = next;
            selected = [];
            final cleared = tutorialBoardMatches(board, puzzle.goalType);
            if (!cleared && i + 1 < puzzle.actions.length) {
              if (puzzle.actions[i + 1].input == TutorialInput.gate) {
                gate = null;
              }
            }
        }
      }

      expect(
        tutorialBoardMatches(board, puzzle.goalType),
        isTrue,
        reason: puzzle.topic.name,
      );
    }
  });
}

List<Position> _selectCell(
  GateType gate,
  List<Position> selected,
  int row,
  int col,
) {
  final position = Position(row, col);
  if (gate.isTwoBitGate) {
    if (selected.isEmpty) return [position];
    return [...selected, position];
  }
  return tutorialSquare(row, col);
}
