import 'package:flutter/material.dart';
import '../../domain/entities/tutorial_content.dart';
import '../../l10n/app_localizations.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/position.dart';
import '../../domain/entities/gate_type.dart';
import '../../domain/entities/piece.dart';
import '../../domain/entities/piece_type.dart';
import 'board_widget.dart';

/// 操作説明のアニメーションデモ
enum _DemoStep { none, selectGate, selectColumn, selectRow, selectFourCells, applyGate }

class TutorialOperationDemo extends StatefulWidget {
  final TutorialAnimation animation;

  const TutorialOperationDemo({
    super.key,
    required this.animation,
  });

  @override
  State<TutorialOperationDemo> createState() => _TutorialOperationDemoState();
}

class _TutorialOperationDemoState extends State<TutorialOperationDemo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  Board _demoBoard = Board.create8x8();
  Board _originalBoard = Board.create8x8(); // 元の盤面を保持
  GateType? _selectedGate;
  List<Position> _selectedPositions = [];
  int? _selectedRow;
  int? _selectedColumn;
  _DemoStep _currentStep = _DemoStep.none;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animation.duration,
      vsync: this,
    )..addListener(() {
        _updateAnimation();
      })..addStatusListener((status) {
        // アニメーションが終了したら最初に戻す
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
        }
      });
    
    _initializeBoard();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initializeBoard() {
    var board = Board.create8x8();
    // デモ用の盤面を初期化（白と黒を配置）
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        final pieceType = (row + col) % 2 == 0 
            ? PieceType.white 
            : PieceType.black;
        final piece = Piece(
          id: 'demo_${row}_$col',
          type: pieceType,
          position: Position(row, col),
        );
        board = board.setPiece(row, col, piece);
      }
    }
    setState(() {
      _demoBoard = board;
      _originalBoard = board; // 元の盤面を保存
    });
  }

  void _updateAnimation() {
    final progress = _controller.value;
    
    // 5秒のアニメーションを5つのステップに分割
    if (progress < 0.2) {
      // ステップ1: ゲート選択（0-1秒）
      _showGateSelection();
    } else if (progress < 0.4) {
      // ステップ2: 縦1列選択（1-2秒）
      _showColumnSelection();
    } else if (progress < 0.6) {
      // ステップ3: 横1列選択（2-3秒）
      _showRowSelection();
    } else if (progress < 0.8) {
      // ステップ4: 4マス選択（3-4秒）
      _showFourPiecesSelection();
    } else {
      // ステップ5: ゲート適用（4-5秒）
      _showGateApplication();
    }
  }

  void _showGateSelection() {
    setState(() {
      // 盤面を元の状態にリセット
      _demoBoard = _originalBoard;
      _selectedGate = GateType.x;
      _selectedPositions = [];
      _selectedRow = null;
      _selectedColumn = null;
      _currentStep = _DemoStep.selectGate;
    });
  }

  void _showColumnSelection() {
    setState(() {
      // 盤面を元の状態にリセット
      _demoBoard = _originalBoard;
      _selectedGate = GateType.x;
      _selectedColumn = 3; // 列3を選択
      _selectedRow = null;
      _selectedPositions = List.generate(8, (row) => Position(row, 3));
      _currentStep = _DemoStep.selectColumn;
    });
  }

  void _showRowSelection() {
    setState(() {
      // 盤面を元の状態にリセット
      _demoBoard = _originalBoard;
      _selectedGate = GateType.x;
      _selectedRow = 4; // 行4を選択
      _selectedColumn = null;
      _selectedPositions = List.generate(8, (col) => Position(4, col));
      _currentStep = _DemoStep.selectRow;
    });
  }

  void _showFourPiecesSelection() {
    setState(() {
      // 盤面を元の状態にリセット
      _demoBoard = _originalBoard;
      _selectedGate = GateType.x;
      _selectedRow = null;
      _selectedColumn = null;
      // 4マス選択（行2-3, 列2-3）
      _selectedPositions = [
        const Position(2, 2),
        const Position(2, 3),
        const Position(3, 2),
        const Position(3, 3),
      ];
      _currentStep = _DemoStep.selectFourCells;
    });
  }

  void _showGateApplication() {
    setState(() {
      _selectedGate = GateType.x;
      _currentStep = _DemoStep.applyGate;
      // ゲート適用の視覚効果（元の盤面から選択位置の駒を反転）
      var newBoard = _originalBoard;
      for (final pos in _selectedPositions) {
        final piece = newBoard.getPiece(pos.row, pos.col);
        if (piece != null) {
          final newType = piece.type == PieceType.white
              ? PieceType.black
              : PieceType.white;
          final newPiece = piece.copyWith(type: newType);
          newBoard = newBoard.setPiece(pos.row, pos.col, newPiece);
        }
      }
      _demoBoard = newBoard;
    });
  }

  String _stepLabel(AppLocalizations l10n) {
    switch (_currentStep) {
      case _DemoStep.none:
        return '';
      case _DemoStep.selectGate:
        return l10n.tutorialDemoSelectGate;
      case _DemoStep.selectColumn:
        return l10n.tutorialDemoSelectColumn;
      case _DemoStep.selectRow:
        return l10n.tutorialDemoSelectRow;
      case _DemoStep.selectFourCells:
        return l10n.tutorialDemoSelectFourCells;
      case _DemoStep.applyGate:
        return l10n.applyGate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 現在のステップ表示
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6B46C1).withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _stepLabel(AppLocalizations.of(context)),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // ミニボード
        Expanded(
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: BoardWidget(
                  board: _demoBoard,
                  selectedPositions: _selectedPositions,
                  highlightedPositions: const [],
                  lastTwoBitGatePositions: const [],
                  enableRowColumnButtons: true,
                  selectedGate: _selectedGate,
                  selectedRows: _selectedRow != null ? {_selectedRow!: true} : {},
                  selectedColumns: _selectedColumn != null ? {_selectedColumn!: true} : {},
                  cellSize: 35, // ミニボード用の小さなサイズ
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // ゲート適用ボタン（デモ用）
        if (_selectedGate != null && _selectedPositions.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: _currentStep == _DemoStep.applyGate
                  ? const Color(0xFF4CAF50)
                  : const Color(0xFF4CAF50).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              boxShadow: _currentStep == _DemoStep.applyGate
                  ? [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              AppLocalizations.of(context).applyGate,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

