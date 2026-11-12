import '../../domain/entities/board.dart';
import '../../domain/entities/game_mode.dart';
import '../../domain/entities/game_state.dart';
import '../../domain/entities/gate_type.dart';
import '../../domain/entities/piece.dart';
import '../../domain/entities/piece_type.dart';
import '../../domain/entities/player.dart';
import '../../domain/entities/position.dart';
import '../../domain/services/gate_service.dart';

/// 体験チュートリアルでユーザーが次に行う操作。
enum TutorialInput { gate, cell, row, column, apply }

/// 吹き出しに出す誘導文の種類（文言は AppLocalizations で解決する）。
enum TutorialHint { selectWholeRow, cnotBlackControl }

/// 課題のタイトル種別（文言は AppLocalizations で解決する）。
enum TutorialTopic { controls, hGate, yGate, zGate, swapGate, cnotGate }

/// スクリプト上の1タップ。
class TutorialAction {
  final TutorialInput input;
  final GateType? gate;
  final int row;
  final int col;

  /// 適用しても盤が変わらない手順（CNOTの効かない順）。
  final bool noChange;

  /// 吹き出しに出す誘導文の種類（文言は AppLocalizations で解決する）。
  final TutorialHint? hint;

  /// この手順だけ、操作の前に解説する。
  final bool explain;

  const TutorialAction.gate(
    GateType this.gate, {
    this.hint,
    this.explain = false,
  })  : input = TutorialInput.gate,
        row = 0,
        col = 0,
        noChange = false;

  const TutorialAction.cell(
    this.row,
    this.col, {
    this.hint,
    this.explain = false,
  })  : input = TutorialInput.cell,
        gate = null,
        noChange = false;

  const TutorialAction.row(
    this.row, {
    this.hint,
    this.explain = false,
  })  : input = TutorialInput.row,
        gate = null,
        col = 0,
        noChange = false;

  const TutorialAction.column(
    this.col, {
    this.hint,
    this.explain = false,
  })  : input = TutorialInput.column,
        gate = null,
        row = 0,
        noChange = false;

  const TutorialAction.apply({
    this.noChange = false,
    this.explain = false,
  })  : input = TutorialInput.apply,
        hint = null,
        gate = null,
        row = 0,
        col = 0;
}

class TutorialCell {
  final int row;
  final int col;
  final PieceType type;

  const TutorialCell(this.row, this.col, this.type);
}

/// 1つのクリア課題。
class TutorialPuzzle {
  final TutorialTopic topic;
  final PieceType goalType;
  final PieceType fill;
  final List<TutorialCell> overrides;
  final List<TutorialAction> actions;

  const TutorialPuzzle({
    required this.topic,
    required this.goalType,
    required this.fill,
    required this.overrides,
    required this.actions,
  });

  Board buildBoard() {
    var board = Board.create8x8();
    for (var row = 0; row < 8; row++) {
      for (var col = 0; col < 8; col++) {
        var type = fill;
        for (final cell in overrides) {
          if (cell.row == row && cell.col == col) {
            type = cell.type;
          }
        }
        board = board.setPiece(
          row,
          col,
          Piece(
            id: 'tutorial-$row-$col',
            type: type,
            position: Position(row, col),
          ),
        );
      }
    }
    return board;
  }
}

/// 中央の正方4マス（マス(3,3)を含む）。
const List<TutorialCell> _centerBlack = [
  TutorialCell(3, 3, PieceType.black),
  TutorialCell(3, 4, PieceType.black),
  TutorialCell(4, 3, PieceType.black),
  TutorialCell(4, 4, PieceType.black),
];

const List<TutorialCell> _centerWhite = [
  TutorialCell(3, 3, PieceType.white),
  TutorialCell(3, 4, PieceType.white),
  TutorialCell(4, 3, PieceType.white),
  TutorialCell(4, 4, PieceType.white),
];

const List<TutorialCell> _centerPlus = [
  TutorialCell(3, 3, PieceType.grayPlus),
  TutorialCell(3, 4, PieceType.grayPlus),
  TutorialCell(4, 3, PieceType.grayPlus),
  TutorialCell(4, 4, PieceType.grayPlus),
];

const List<TutorialCell> _centerMinus = [
  TutorialCell(3, 3, PieceType.grayMinus),
  TutorialCell(3, 4, PieceType.grayMinus),
  TutorialCell(4, 3, PieceType.grayMinus),
  TutorialCell(4, 4, PieceType.grayMinus),
];

const List<TutorialCell> _topRowWhite = [
  TutorialCell(0, 0, PieceType.white),
  TutorialCell(0, 1, PieceType.white),
  TutorialCell(0, 2, PieceType.white),
  TutorialCell(0, 3, PieceType.white),
  TutorialCell(0, 4, PieceType.white),
  TutorialCell(0, 5, PieceType.white),
  TutorialCell(0, 6, PieceType.white),
  TutorialCell(0, 7, PieceType.white),
];

const List<TutorialCell> _leftColumnBlack = [
  TutorialCell(0, 0, PieceType.black),
  TutorialCell(1, 0, PieceType.black),
  TutorialCell(2, 0, PieceType.black),
  TutorialCell(3, 0, PieceType.black),
  TutorialCell(4, 0, PieceType.black),
  TutorialCell(5, 0, PieceType.black),
  TutorialCell(6, 0, PieceType.black),
  TutorialCell(7, 0, PieceType.black),
];

const List<TutorialCell> _swapSetup = [
  TutorialCell(3, 0, PieceType.white),
  TutorialCell(3, 1, PieceType.white),
  TutorialCell(3, 2, PieceType.white),
  TutorialCell(3, 3, PieceType.black),
  TutorialCell(3, 4, PieceType.white),
  TutorialCell(3, 5, PieceType.white),
  TutorialCell(3, 6, PieceType.white),
  TutorialCell(3, 7, PieceType.white),
  TutorialCell(2, 3, PieceType.white),
];

/// 初回チュートリアルの全課題。文章は、押し方が初めてのときだけ出す。
const List<TutorialPuzzle> interactiveTutorialPuzzles = [
  TutorialPuzzle(
    topic: TutorialTopic.controls,
    goalType: PieceType.white,
    fill: PieceType.white,
    overrides: _centerBlack,
    actions: [
      TutorialAction.gate(GateType.x),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.controls,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: _topRowWhite,
    actions: [
      TutorialAction.gate(GateType.x),
      TutorialAction.row(
        0,
        hint: TutorialHint.selectWholeRow,
        explain: true,
      ),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.controls,
    goalType: PieceType.white,
    fill: PieceType.white,
    overrides: _leftColumnBlack,
    actions: [
      TutorialAction.gate(GateType.x),
      TutorialAction.column(0),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.hGate,
    goalType: PieceType.white,
    fill: PieceType.white,
    overrides: _centerPlus,
    actions: [
      TutorialAction.gate(GateType.h),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.hGate,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: _centerMinus,
    actions: [
      TutorialAction.gate(GateType.h),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.yGate,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: _centerWhite,
    actions: [
      TutorialAction.gate(GateType.y),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.yGate,
    goalType: PieceType.white,
    fill: PieceType.white,
    overrides: _centerMinus,
    actions: [
      TutorialAction.gate(GateType.y),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
      TutorialAction.gate(GateType.h),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.zGate,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: _centerPlus,
    actions: [
      TutorialAction.gate(GateType.z),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
      TutorialAction.gate(GateType.h),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.swapGate,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: _swapSetup,
    actions: [
      TutorialAction.gate(GateType.swap),
      TutorialAction.cell(2, 3),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(),
      TutorialAction.gate(GateType.x),
      TutorialAction.row(3),
      TutorialAction.apply(),
    ],
  ),
  TutorialPuzzle(
    topic: TutorialTopic.cnotGate,
    goalType: PieceType.black,
    fill: PieceType.black,
    overrides: [
      TutorialCell(3, 4, PieceType.white),
    ],
    actions: [
      TutorialAction.gate(GateType.cnot),
      TutorialAction.cell(3, 4),
      TutorialAction.cell(3, 3),
      TutorialAction.apply(noChange: true),
      TutorialAction.gate(
        GateType.cnot,
        hint: TutorialHint.cnotBlackControl,
        explain: true,
      ),
      TutorialAction.cell(3, 3),
      TutorialAction.cell(3, 4),
      TutorialAction.apply(),
    ],
  ),
];

/// 盤内タップで選ばれる正方4マス。右端・下端は本編と同じ補正。
List<Position> tutorialSquare(int row, int col) {
  var baseRow = row;
  var baseCol = col;
  if (col == 7) baseCol = col - 1;
  if (row == 7) baseRow = row - 1;
  return [
    Position(baseRow, baseCol),
    Position(baseRow, baseCol + 1),
    Position(baseRow + 1, baseCol),
    Position(baseRow + 1, baseCol + 1),
  ];
}

List<Position> tutorialRow(int row) =>
    [for (var col = 0; col < 8; col++) Position(row, col)];

List<Position> tutorialColumn(int col) =>
    [for (var row = 0; row < 8; row++) Position(row, col)];

bool tutorialBoardMatches(Board board, PieceType goal) {
  for (var row = 0; row < board.rows; row++) {
    for (var col = 0; col < board.cols; col++) {
      final piece = board.getPiece(row, col);
      if (piece == null || piece.type != goal) return false;
    }
  }
  return true;
}

bool tutorialBoardsEqual(Board a, Board b) {
  for (var row = 0; row < a.rows; row++) {
    for (var col = 0; col < a.cols; col++) {
      if (a.getPiece(row, col)?.type != b.getPiece(row, col)?.type) {
        return false;
      }
    }
  }
  return true;
}

/// チャレンジと同じく、手番は黒。CNOTは1駒目が黒のときだけ2駒目を反転する。
Board applyTutorialGate(
  Board board,
  GateType gate,
  List<Position> positions,
) {
  const player = Player(id: 1, color: PlayerColor.black);
  final state = GameState(
    board: board,
    gameMode: GameMode.challenge,
    players: const {1: player},
  );
  return GateService().applyGate(state, gate, positions).board;
}
