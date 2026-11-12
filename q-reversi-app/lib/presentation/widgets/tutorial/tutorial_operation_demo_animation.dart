import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../../../domain/entities/board.dart';
import '../../../domain/entities/position.dart';
import '../../../domain/entities/gate_type.dart';
import '../../../domain/entities/piece_type.dart';
import '../../../domain/entities/piece.dart';
import '../../gate_effect_icon_setting.dart';
import '../board_widget.dart';
import '../gate_button.dart';
import '../gate_button_grid.dart';

/// 基本操作デモアニメーション
class TutorialOperationDemoAnimation extends StatefulWidget {
  const TutorialOperationDemoAnimation({super.key});

  @override
  State<TutorialOperationDemoAnimation> createState() =>
      _TutorialOperationDemoAnimationState();
}

class _TutorialOperationDemoAnimationState
    extends State<TutorialOperationDemoAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  Board _board = Board.create8x8();
  GateType? _selectedGate;
  List<Position> _selectedPositions = [];
  Map<int, bool> _selectedRows = {};
  Map<int, bool> _selectedColumns = {};
  int _currentStep = 0;
  int _pieceIdCounter = 0;

  // アニメーションステップの定義
  static const int _totalSteps = 9;

  // hand.png用のGlobalKey
  final Map<GateType, GlobalKey> _gateButtonKeys = {};
  final GlobalKey _applyButtonKey = GlobalKey();
  final GlobalKey _boardKey = GlobalKey();
  final GlobalKey _stackKey = GlobalKey(); // Stackの位置を取得するためのキー
  final Map<String, GlobalKey> _boardCustomKeys = {
    'column_top_1': GlobalKey(), // 左から2番目の列選択ボタン(上) - 列1（0-indexed）
    'row_left_2': GlobalKey(), // 上から3番目の行選択ボタン(左) - 行2（0-indexed）
    'cell_4_4': GlobalKey(), // 盤面の(4,4)座標
  };

  // hand.pngの位置
  Offset? _handPosition;
  bool _handVisible = false;
  int _pendingStep = -1; // 待機中のステップ

  // hand.pngのサイズ（10x10グリッドで(4,2)が人差し指）
  static const double _handWidth = 100.0 * 2 / 3; // 2/3のサイズ
  static const double _handHeight = 100.0 * 2 / 3; // 2/3のサイズ
  static const double _fingerOffsetX = _handWidth * 4 / 10; // (4,2)のX座標
  static const double _fingerOffsetY = _handHeight * 2 / 10; // (4,2)のY座標
  static const Duration _handAnimationDuration = Duration(milliseconds: 300);
  // hand.pngの位置更新と盤面更新の間の遅延
  static const Duration _boardUpdateDelay = Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    
    // GlobalKeyを初期化
    for (final gate in GateType.values.where((g) => g.isOneBitGate)) {
      _gateButtonKeys[gate] = GlobalKey();
    }
    
    // 初期盤面を設定（白と黒の駒を配置）
    _initializeBoard();
    
    // 初期状態を設定
    _updateStep();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 15), // 全体で15秒
      vsync: this,
    )..addListener(() {
        // hand.pngを少し早く動かすために、ステップの切り替えを早める（0.05ステップ分早く）
        final step = ((_controller.value * _totalSteps) - 0.05).floor();
        if (step != _currentStep && step >= 0 && step < _totalSteps && _pendingStep == -1) {
          // まずhand.pngの位置を更新してから、移動完了後に盤面を更新
          _pendingStep = step;
          _moveHandToStep(step);
        }
      });
    
    _controller.repeat();
    GateEffectIconSetting.instance.notifier.addListener(_onIconSetting);

    // 初期位置を設定
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateHandPosition();
    });
  }

  void _initializeBoard() {
    // デモ用の初期盤面を設定
    // すべてのマスに駒を配置
    // 奇数行目（0, 2, 4, 6行目）: 白黒白黒...
    // 偶数行目（1, 3, 5, 7行目）: 黒白黒白...
    for (int row = 0; row < 8; row++) {
      for (int col = 0; col < 8; col++) {
        final pos = Position(row, col);
        PieceType pieceType;
        
        if (row % 2 == 0) {
          // 奇数行目（0, 2, 4, 6行目）: 白黒白黒...
          pieceType = col % 2 == 0 ? PieceType.white : PieceType.black;
        } else {
          // 偶数行目（1, 3, 5, 7行目）: 黒白黒白...
          pieceType = col % 2 == 0 ? PieceType.black : PieceType.white;
        }
        
        _board = _board.setPiece(row, col, Piece(
          id: 'piece_${_pieceIdCounter++}',
          type: pieceType,
          position: pos,
        ));
      }
    }
  }

  void _updateStep() {
    debugPrint('_updateStep called: _currentStep = $_currentStep');
    switch (_currentStep) {
      case 0:
        // ステップ1: Xゲートボタンをタップ
        _selectedGate = GateType.x;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        _handVisible = true;
        debugPrint('Step 0: _selectedGate = $_selectedGate, _selectedColumns = $_selectedColumns');
        break;
      case 1:
        // ステップ2: 縦一列（左から2列目）を選択
        // _selectedGateは前のステップから継承（GateType.x）
        _selectedColumns = {1: true};
        _selectedPositions = [];
        _selectedRows = {};
        debugPrint('Step 1: _selectedGate = $_selectedGate, _selectedColumns = $_selectedColumns');
        debugPrint('Step 1: canApply = ${_selectedGate != null && (_selectedPositions.isNotEmpty || _selectedRows.isNotEmpty || _selectedColumns.isNotEmpty)}');
        break;
      case 2:
        // ステップ3: 「ゲートを適用」ボタンをタップ → 駒が変化
        _applyGate();
        // 状態をクリア（ゲート適用後）
        _selectedGate = null;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        _handVisible = true;
        break;
      case 3:
        // ステップ4: Yゲートボタンをタップ
        _selectedGate = GateType.y;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        break;
      case 4:
        // ステップ5: 横一列（上から3行目）を選択
        // _selectedGateは前のステップから継承（GateType.y）
        _selectedRows = {2: true};
        _selectedPositions = [];
        _selectedColumns = {};
        break;
      case 5:
        // ステップ6: 「ゲートを適用」ボタンをタップ → 駒が変化
        _applyGate();
        // 状態をクリア（ゲート適用後）
        _selectedGate = null;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        _handVisible = true;
        break;
      case 6:
        // ステップ7: Hゲートボタンをタップ
        _selectedGate = GateType.h;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        break;
      case 7:
        // ステップ8: 中央4マス（(3,3), (3,4), (4,3), (4,4)）を選択
        // _selectedGateは前のステップから継承（GateType.h）
        _selectedPositions = [
          const Position(3, 3),
          const Position(3, 4),
          const Position(4, 3),
          const Position(4, 4),
        ];
        _selectedRows = {};
        _selectedColumns = {};
        break;
      case 8:
        // ステップ9: 「ゲートを適用」ボタンをタップ → 駒が変化
        _applyGate();
        // 状態をクリア（ゲート適用後）
        _selectedGate = null;
        _selectedPositions = [];
        _selectedRows = {};
        _selectedColumns = {};
        _handVisible = true;
        break;
    }
  }

  void _applyGate() {
    if (_selectedGate == null) return;
    
    // ゲート適用のロジックを簡易実装
    var newBoard = _board;
    
    if (_selectedGate!.isOneBitGate) {
      List<Position> targetPositions = [];
      
      if (_selectedRows.isNotEmpty) {
        // 行選択
        for (final rowEntry in _selectedRows.entries) {
          if (rowEntry.value) {
            for (int col = 0; col < 8; col++) {
              targetPositions.add(Position(rowEntry.key, col));
            }
          }
        }
      } else if (_selectedColumns.isNotEmpty) {
        // 列選択
        for (final colEntry in _selectedColumns.entries) {
          if (colEntry.value) {
            for (int row = 0; row < 8; row++) {
              targetPositions.add(Position(row, colEntry.key));
            }
          }
        }
      } else if (_selectedPositions.isNotEmpty) {
        // 4マス選択
        targetPositions = _selectedPositions;
      }
      
      // ゲートを適用
      for (final pos in targetPositions) {
        final piece = newBoard.getPiece(pos.row, pos.col);
        if (piece == null) continue;
        
        final newType = _applyOneBitGateToPiece(piece.type, _selectedGate!);
        final newPiece = piece.copyWith(type: newType, position: pos);
        newBoard = newBoard.setPiece(pos.row, pos.col, newPiece);
      }
    }
    
    // ゲート適用後、盤面のみを更新
    // 選択状態は次のステップでクリアされる
    _board = newBoard;
  }

  PieceType _applyOneBitGateToPiece(PieceType pieceType, GateType gate) {
    switch (gate) {
      case GateType.x:
        if (pieceType == PieceType.white) return PieceType.black;
        if (pieceType == PieceType.black) return PieceType.white;
        return pieceType;
        
      case GateType.h:
        if (pieceType == PieceType.grayPlus) return PieceType.white;
        if (pieceType == PieceType.white) return PieceType.grayPlus;
        if (pieceType == PieceType.grayMinus) return PieceType.black;
        if (pieceType == PieceType.black) return PieceType.grayMinus;
        return pieceType;
        
      case GateType.y:
        if (pieceType == PieceType.white) return PieceType.black;
        if (pieceType == PieceType.black) return PieceType.white;
        if (pieceType == PieceType.grayPlus) return PieceType.grayMinus;
        if (pieceType == PieceType.grayMinus) return PieceType.grayPlus;
        return pieceType;
        
      case GateType.z:
        if (pieceType == PieceType.grayPlus) return PieceType.grayMinus;
        if (pieceType == PieceType.grayMinus) return PieceType.grayPlus;
        return pieceType;
        
      default:
        return pieceType;
    }
  }

  void _onIconSetting() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    GateEffectIconSetting.instance.notifier.removeListener(_onIconSetting);
    _controller.dispose();
    super.dispose();
  }

  /// hand.pngを指定されたステップの位置に移動し、完了後に盤面を更新
  void _moveHandToStep(int step) {
    // レイアウト後にhand.pngの位置を更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Offset? targetPosition;
      bool shouldShow = false;

      switch (step) {
        case 0:
          // Xゲートボタン
          targetPosition = _getButtonPosition(_gateButtonKeys[GateType.x]);
          shouldShow = true;
          break;
        case 1:
          // 左から2番目の列選択ボタン(上) - 列1（0-indexed）
          targetPosition = _getButtonPosition(_boardCustomKeys['column_top_1'], isColumnOrRowButton: true);
          shouldShow = true;
          break;
        case 2:
          // ゲートを適用ボタン
          targetPosition = _getButtonPosition(_applyButtonKey);
          shouldShow = true;
          break;
        case 3:
          // Yゲートボタン
          targetPosition = _getButtonPosition(_gateButtonKeys[GateType.y]);
          shouldShow = true;
          break;
        case 4:
          // 上から3番目の行選択ボタン(左) - 行2（0-indexed）
          targetPosition = _getButtonPosition(_boardCustomKeys['row_left_2'], isColumnOrRowButton: true);
          shouldShow = true;
          break;
        case 5:
          // ゲートを適用ボタン
          targetPosition = _getButtonPosition(_applyButtonKey);
          shouldShow = true;
          break;
        case 6:
          // Hゲートボタン
          targetPosition = _getButtonPosition(_gateButtonKeys[GateType.h]);
          shouldShow = true;
          break;
        case 7:
          // 盤面上の(4,4)座標 - 1.5マス左、1マス上にずらす
          targetPosition = _getButtonPosition(_boardCustomKeys['cell_4_4'], isCellButton: true);
          shouldShow = true;
          break;
        case 8:
          // ゲートを適用ボタン
          targetPosition = _getButtonPosition(_applyButtonKey);
          shouldShow = true;
          break;
      }

      if (targetPosition != null) {
        setState(() {
          _handPosition = targetPosition;
          _handVisible = shouldShow;
        });

        // hand.pngの移動アニメーションが完了してから、さらに少し時間を置いて盤面を更新
        Future.delayed(_handAnimationDuration + _boardUpdateDelay, () {
          if (mounted && _pendingStep == step) {
            setState(() {
              _currentStep = step;
              _pendingStep = -1;
              _updateStep();
            });
          }
        });
      } else {
        // 位置が取得できない場合は、すぐに盤面を更新
        if (mounted && _pendingStep == step) {
          setState(() {
            _currentStep = step;
            _pendingStep = -1;
            _updateStep();
          });
        }
      }
    });
  }

  /// hand.pngの位置を更新（既存のメソッド、後方互換性のため保持）
  void _updateHandPosition() {
    _moveHandToStep(_currentStep);
  }

  /// ボタンの位置を取得（hand.pngの(4,2)座標がボタンの中心に来るように調整）
  Offset? _getButtonPosition(GlobalKey? key, {bool isColumnOrRowButton = false, bool isCellButton = false}) {
    if (key?.currentContext == null) return null;
    final RenderBox? box = key!.currentContext!.findRenderObject() as RenderBox?;
    if (box == null) return null;
    
    // Stackの位置を取得
    final RenderBox? stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null) return null;
    
    // ボタンの画面座標
    final buttonGlobalPosition = box.localToGlobal(Offset.zero);
    // Stackの画面座標
    final stackGlobalPosition = stackBox.localToGlobal(Offset.zero);
    
    // Stackを基準とした相対位置に変換
    final buttonRelativePosition = buttonGlobalPosition - stackGlobalPosition;
    final size = box.size;
    
    // 列選択ボタンまたは行選択ボタンの場合は、1/5マス分左にずらす
    final columnRowOffset = isColumnOrRowButton ? -size.width / 5 : 0.0;
    
    // 盤面セルボタンの場合は、0.5マス左、0.5マス上にずらす
    final cellOffsetX = isCellButton ? -size.width * 0.8 : 0.0;
    final cellOffsetY = isCellButton ? -size.height * 0.5 : 0.0;
    
    // ボタンの中心位置を計算し、hand.pngの(4,2)座標が来るように調整
    return Offset(
      buttonRelativePosition.dx + size.width / 2 - _fingerOffsetX + columnRowOffset + cellOffsetX,
      buttonRelativePosition.dy + size.height / 2 - _fingerOffsetY + cellOffsetY,
    );
  }

  /// ハイライトする位置のリストを取得
  List<Position> _getHighlightedPositions() {
    final positions = <Position>[];
    
    // 選択された行の位置を追加
    for (final rowEntry in _selectedRows.entries) {
      if (rowEntry.value) {
        for (int col = 0; col < 8; col++) {
          positions.add(Position(rowEntry.key, col));
        }
      }
    }
    
    // 選択された列の位置を追加
    for (final colEntry in _selectedColumns.entries) {
      if (colEntry.value) {
        for (int row = 0; row < 8; row++) {
          positions.add(Position(row, colEntry.key));
        }
      }
    }
    
    // 4マス選択の場合は、選択された位置を追加
    if (_selectedPositions.isNotEmpty && _selectedRows.isEmpty && _selectedColumns.isEmpty) {
      positions.addAll(_selectedPositions);
    }
    
    return positions;
  }

  @override
  Widget build(BuildContext context) {
    // canApplyを計算
    final canApply = _selectedGate != null && 
        (_selectedPositions.isNotEmpty || 
         _selectedRows.isNotEmpty || 
         _selectedColumns.isNotEmpty);
    debugPrint('build() called: _selectedGate = $_selectedGate, _selectedPositions = $_selectedPositions, _selectedRows = $_selectedRows, _selectedColumns = $_selectedColumns, canApply = $canApply');
    
    // LayoutBuilderを使って利用可能な高さを取得
    return LayoutBuilder(
      builder: (context, constraints) {
        // 利用可能な高さから、ゲートボタンと適用ボタンの高さを引く
        final showIcons = GateEffectIconSetting.instance.notifier.value;
        final gateButtonAreaHeight =
            showIcons ? 210.0 : 120.0; // ゲートボタンエリアの推定高さ
        const applyButtonHeight = 60.0; // 適用ボタンの高さ
        const padding = 16.0 * 2; // 上下のパディング
        final availableHeight = constraints.maxHeight - gateButtonAreaHeight - applyButtonHeight - padding;
        
        return Stack(
          key: _stackKey,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ボード（利用可能な高さに合わせて縮小）
                Flexible(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: availableHeight.clamp(200.0, double.infinity),
                      maxWidth: constraints.maxWidth,
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: _buildBoardWithKeys(),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                // 下部エリア（固定サイズ）
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ゲート選択UI
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: GateEffectIconSetting.instance.notifier,
                        builder: (context, iconsOn, _) {
                          const gates = [
                            GateType.h,
                            GateType.x,
                            GateType.y,
                            GateType.z,
                          ];
                          final rows = iconsOn
                              ? chunkGateRows(gates, 2)
                              : [gates];
                          return GateButtonGrid(
                            rows: rows,
                            showEffectIcon: iconsOn,
                            itemBuilder: (gate) => GateButton(
                              key: _gateButtonKeys[gate],
                              gate: gate,
                              isEnabled: true,
                              isSelected: _selectedGate == gate,
                              showEffectIcon: iconsOn,
                              onTap: null, // デモなのでタップ無効
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // ゲートを適用ボタン
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ElevatedButton(
                        key: _applyButtonKey,
                        onPressed: null, // デモなのでタップ無効
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          backgroundColor: canApply
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade700,
                          foregroundColor: Colors.white,
                        ).copyWith(
                          // 明示的にbackgroundColorを設定
                          backgroundColor: WidgetStateProperty.all<Color>(
                            canApply
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade700,
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context).applyGate,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // hand.pngを上から描画
            if (_handPosition != null && _handVisible)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _handPosition!.dx,
                top: _handPosition!.dy,
                child: Image.asset(
                  'assets/hand.png',
                  width: _handWidth,
                  height: _handHeight,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        );
      },
    );
  }

  /// キー付きのボードを構築（列選択ボタン、行選択ボタン、盤面セルにキーを追加）
  Widget _buildBoardWithKeys() {
    return BoardWidget(
      key: _boardKey,
      board: _board,
      selectedPositions: _selectedPositions,
      highlightedPositions: _getHighlightedPositions(),
      lastTwoBitGatePositions: const [],
      selectedGate: _selectedGate,
      selectedRows: _selectedRows,
      selectedColumns: _selectedColumns,
      enableRowColumnButtons: true,
      forbiddenAreas: null,
      customKeys: _boardCustomKeys,
      onRowSelected: null,
      onColumnSelected: null,
      onPositionTap: null,
    );
  }
}
