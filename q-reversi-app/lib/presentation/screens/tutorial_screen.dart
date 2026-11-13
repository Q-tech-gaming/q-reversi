import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/background_music.dart';
import '../../core/sound_effects.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/gate_type.dart';
import '../../domain/entities/piece_type.dart';
import '../../domain/entities/position.dart';
import '../../domain/services/tutorial_progress_service.dart';
import '../../l10n/app_localizations.dart';
import '../tutorial/interactive_tutorial_script.dart';
import '../gate_effect_icon_setting.dart';
import '../widgets/board_widget.dart';
import '../widgets/gate_button.dart';
import '../widgets/gate_button_grid.dart';
import '../widgets/tutorial_step_guide.dart';

/// 盤面を操作してゲートの効果を学ぶチュートリアル。
class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  /// 以前は完了後にチャレンジを開くための戻り値。いまはモード選択へ戻るだけ。
  static const String resultOpenChallenge = 'open_challenge';

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen>
    with TickerProviderStateMixin {
  final TutorialProgressService _progressService = TutorialProgressService();
  final List<TutorialPuzzle> _puzzles = interactiveTutorialPuzzles;

  late final BgmHandle _bgm;
  late final AnimationController _pulse;
  late final AnimationController _shake;

  late Board _board;
  int _puzzleIndex = 0;
  int _actionIndex = 0;
  GateType? _selectedGate;
  List<Position> _selectedPositions = [];
  int? _selectedRow;
  int? _selectedColumn;
  List<Position> _highlight = [];
  bool _locked = false;
  bool _done = false;
  bool _briefing = false;
  int _briefStep = 0;
  int? _introStep = 0;
  bool _showClear = false;
  String? _clearDetail;
  int _clearToken = 0;
  bool _returned = false;
  bool _guideFramePending = false;

  String _topicTitle(AppLocalizations l10n, TutorialTopic topic) {
    switch (topic) {
      case TutorialTopic.controls:
        return l10n.tutorialTopicControls;
      case TutorialTopic.hGate:
        return l10n.tutorialTopicHGate;
      case TutorialTopic.yGate:
        return l10n.tutorialTopicYGate;
      case TutorialTopic.zGate:
        return l10n.tutorialTopicZGate;
      case TutorialTopic.swapGate:
        return l10n.tutorialTopicSwapGate;
      case TutorialTopic.cnotGate:
        return l10n.tutorialTopicCnotGate;
    }
  }

  String _goalLabel(AppLocalizations l10n, PieceType goal) =>
      goal == PieceType.black ? l10n.victoryAllBlack : l10n.victoryAllWhite;

  String _briefText(AppLocalizations l10n, TutorialBrief? brief) {
    switch (brief) {
      case TutorialBrief.cnotBlackControl:
        return l10n.tutorialHintCnotBlackControl;
      case null:
        return '';
    }
  }

  String? _clearNoteText(AppLocalizations l10n, TutorialClearNote? note) {
    switch (note) {
      case TutorialClearNote.piecesChange:
        return l10n.tutorialClearNotePiecesChange;
      case TutorialClearNote.selectLine:
        return l10n.tutorialHintSelectWholeRow;
      case TutorialClearNote.differentEffects:
        return l10n.tutorialClearNoteEffects;
      case TutorialClearNote.twoPieces:
        return l10n.tutorialClearNoteTwoPieces;
      case null:
        return null;
    }
  }

  final GlobalKey _guideStackKey = GlobalKey();
  final GlobalKey _applyKey = GlobalKey();
  final Map<GateType, GlobalKey> _gateKeys = {
    for (final gate in GateType.values) gate: GlobalKey(),
  };
  late final Map<String, GlobalKey> _boardKeys = Map.fromEntries(
    [
      for (var row = 0; row < 8; row++)
        for (var col = 0; col < 8; col++) 'cell_${row}_$col',
      for (var row = 0; row < 8; row++) ...[
        'row_left_$row',
        'row_right_$row',
      ],
      for (var col = 0; col < 8; col++) ...[
        'column_top_$col',
        'column_bottom_$col',
      ],
    ].map((name) => MapEntry(name, GlobalKey())),
  );

  static const List<GateType> _oneBitGates = [
    GateType.h,
    GateType.x,
    GateType.y,
    GateType.z,
  ];

  static const List<GateType> _twoBitGates = [
    GateType.cnot,
    GateType.swap,
  ];

  @override
  void initState() {
    super.initState();
    _bgm = BgmHandle.hold(Bgm.study);
    _board = _puzzles.first.buildBoard();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _shake = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
  }

  @override
  void dispose() {
    _bgm.release();
    _pulse.dispose();
    _shake.dispose();
    super.dispose();
  }

  TutorialPuzzle get _puzzle => _puzzles[_puzzleIndex];

  TutorialAction? get _action {
    if (_done || _actionIndex < 0 || _actionIndex >= _puzzle.actions.length) {
      return null;
    }
    return _puzzle.actions[_actionIndex];
  }

  Future<void> _close() async {
    await SoundEffects.instance.untilReversePlaying();
    if (!_done) {
      await _progressService.markTutorialSkipped();
    }
    await _returnToModeSelect();
  }

  Future<void> _returnToModeSelect() async {
    if (_returned || !mounted) return;
    _returned = true;
    Navigator.pop(context);
  }

  bool get _inputBlocked => _locked || _done || _briefing || _introStep != null;

  void _onGate(GateType gate) {
    if (_inputBlocked) return;
    final action = _action;
    if (action == null ||
        action.input != TutorialInput.gate ||
        action.gate != gate) {
      return;
    }
    SoundEffects.instance.gateSelect();
    setState(() {
      _selectedGate = gate;
      if (gate.isTwoBitGate) {
        _selectedPositions = [];
        _selectedRow = null;
        _selectedColumn = null;
      }
      _actionIndex++;
    });
  }

  void _onCell(Position position) {
    if (_inputBlocked) return;
    final action = _action;
    if (action == null || action.input != TutorialInput.cell) return;
    final gate = _selectedGate;
    if (gate == null || !_cellIsTarget(action, position, gate)) return;
    SoundEffects.instance.cellSelect();
    setState(() {
      if (gate.isTwoBitGate) {
        if (_selectedPositions.isEmpty) {
          _selectedPositions = [position];
        } else if (_selectedPositions.length == 1 &&
            position.isAdjacent(_selectedPositions.first)) {
          _selectedPositions = [..._selectedPositions, position];
        }
      } else {
        _selectedRow = null;
        _selectedColumn = null;
        _selectedPositions = tutorialSquare(action.row, action.col);
      }
      _actionIndex++;
    });
  }

  void _onRow(int row) {
    if (_inputBlocked) return;
    final action = _action;
    if (action == null ||
        action.input != TutorialInput.row ||
        action.row != row) {
      return;
    }
    SoundEffects.instance.cellSelect();
    setState(() {
      _selectedColumn = null;
      _selectedRow = row;
      _selectedPositions = tutorialRow(row);
      _actionIndex++;
    });
  }

  void _onColumn(int col) {
    if (_inputBlocked) return;
    final action = _action;
    if (action == null ||
        action.input != TutorialInput.column ||
        action.col != col) {
      return;
    }
    SoundEffects.instance.cellSelect();
    setState(() {
      _selectedRow = null;
      _selectedColumn = col;
      _selectedPositions = tutorialColumn(col);
      _actionIndex++;
    });
  }

  Future<void> _onApply() async {
    if (_inputBlocked) return;
    final action = _action;
    final gate = _selectedGate;
    if (action == null ||
        action.input != TutorialInput.apply ||
        gate == null ||
        _selectedPositions.isEmpty) {
      return;
    }

    final positions = List<Position>.of(_selectedPositions);
    final next = applyTutorialGate(_board, gate, positions);
    final changed = !tutorialBoardsEqual(_board, next);
    final cleared = tutorialBoardMatches(next, _puzzle.goalType);
    final followUpGate = !cleared &&
        _actionIndex + 1 < _puzzle.actions.length &&
        _puzzle.actions[_actionIndex + 1].input == TutorialInput.gate;

    setState(() {
      _locked = true;
      _board = next;
      _selectedPositions = [];
      _selectedRow = null;
      _selectedColumn = null;
      _highlight = action.noChange ? [] : positions;
      if (followUpGate) _selectedGate = null;
    });

    if (action.noChange || !changed) {
      SoundEffects.instance.reverse();
      await _shake.forward(from: 0);
    } else {
      SoundEffects.instance.apply();
      await Future<void>.delayed(const Duration(milliseconds: 560));
    }
    if (!mounted) return;

    if (cleared) {
      await Future<void>.delayed(const Duration(milliseconds: 280));
      if (!mounted) return;
      if (_puzzleIndex >= _puzzles.length - 1) {
        await _completeAndReturn();
        return;
      }
      await _showClearThenContinue();
      return;
    }

    setState(() {
      _highlight = [];
      _actionIndex++;
      _selectedGate = null;
      _briefStep = 0;
      _briefing = _explainIndexes().isNotEmpty;
      _locked = false;
    });
  }

  void _advancePuzzle() {
    setState(() {
      _showClear = false;
      _clearDetail = null;
      _highlight = [];
      _puzzleIndex++;
      _board = _puzzle.buildBoard();
      _actionIndex = 0;
      _selectedPositions = [];
      _selectedRow = null;
      _selectedColumn = null;
      _selectedGate = null;
      _briefStep = 0;
      _briefing = _explainIndexes().isNotEmpty;
      _locked = false;
    });
  }

  Future<void> _showClearThenContinue() async {
    final token = ++_clearToken;
    final detail = _clearNoteText(
      AppLocalizations.of(context),
      _puzzle.clearNote,
    );
    SoundEffects.instance.challengeClear();
    setState(() {
      _highlight = [];
      _showClear = true;
      _clearDetail = detail;
      _locked = true;
      _briefing = false;
    });
    await Future<void>.delayed(const Duration(milliseconds: 3000));
    if (!mounted || token != _clearToken) return;
    _advancePuzzle();
  }

  void _skipClear() {
    if (!_showClear) return;
    _clearToken++;
    _advancePuzzle();
  }

  Future<void> _completeAndReturn() async {
    SoundEffects.instance.challengeClear();
    await _progressService.markTutorialCompleted();
    if (!mounted) return;
    setState(() {
      _highlight = [];
      _done = true;
      _locked = false;
      _briefing = false;
      _introStep = null;
    });
    await Future<void>.delayed(const Duration(milliseconds: 2400));
    await _returnToModeSelect();
  }

  void _nextIntro() {
    if (_introStep == null) return;
    SoundEffects.instance.click();
    setState(() {
      _introStep = null;
      _briefStep = 0;
      _briefing = _explainIndexes().isNotEmpty;
    });
  }

  bool _cellIsTarget(TutorialAction action, Position position, GateType gate) {
    if (gate.isTwoBitGate) {
      return action.row == position.row && action.col == position.col;
    }
    return tutorialSquare(action.row, action.col).any(
      (cell) => cell.row == position.row && cell.col == position.col,
    );
  }

  List<Position> _suggestedCells(TutorialAction action) {
    final gate = _selectedGate;
    if (gate != null && gate.isTwoBitGate) {
      return [Position(action.row, action.col)];
    }
    return tutorialSquare(action.row, action.col);
  }

  List<int> _explainIndexes() {
    final indexes = <int>[];
    for (var i = _actionIndex; i < _puzzle.actions.length; i++) {
      final action = _puzzle.actions[i];
      if (action.explain) indexes.add(i);
      if (action.input == TutorialInput.apply) break;
    }
    return indexes;
  }

  TutorialAction? get _briefAction {
    if (!_briefing) return null;
    final indexes = _explainIndexes();
    if (_briefStep < 0 || _briefStep >= indexes.length) return null;
    return _puzzle.actions[indexes[_briefStep]];
  }

  void _nextBrief() {
    SoundEffects.instance.click();
    final last = _explainIndexes().length - 1;
    if (_briefStep >= last) {
      setState(() => _briefing = false);
      return;
    }
    setState(() => _briefStep++);
  }

  GlobalKey? _targetKey(TutorialAction action) {
    switch (action.input) {
      case TutorialInput.gate:
        return _gateKeys[action.gate];
      case TutorialInput.cell:
        return _boardKeys['cell_${action.row}_${action.col}'];
      case TutorialInput.row:
        return _boardKeys['row_left_${action.row}'];
      case TutorialInput.column:
        return _boardKeys['column_top_${action.col}'];
      case TutorialInput.apply:
        return _applyKey;
    }
  }

  Rect? _guideRectFor(GlobalKey key) {
    final target = key.currentContext?.findRenderObject();
    final stack = _guideStackKey.currentContext?.findRenderObject();
    if (target is! RenderBox ||
        stack is! RenderBox ||
        !target.hasSize ||
        !stack.hasSize) {
      _ensureGuideFrame();
      return null;
    }
    final topLeft = stack.globalToLocal(target.localToGlobal(Offset.zero));
    final bottomRight = stack.globalToLocal(
      target.localToGlobal(target.size.bottomRight(Offset.zero)),
    );
    return Rect.fromPoints(topLeft, bottomRight);
  }

  void _ensureGuideFrame() {
    if (_guideFramePending) return;
    _guideFramePending = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _guideFramePending = false;
      if (mounted) setState(() {});
    });
  }

  String _statusText(AppLocalizations l10n) {
    final gate = _selectedGate;
    if (gate == null) return l10n.tutorialSelectGateButton;
    if (gate.isTwoBitGate) {
      if (_selectedPositions.isEmpty) return l10n.tutorialStatusSelectFirstCell;
      if (_selectedPositions.length == 1) {
        return l10n.tutorialStatusSelectSecondCell;
      }
      return l10n.tutorialStatusTwoCellsSelected;
    }
    return l10n.tutorialStatusSelectRowColumnOrCell;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final action = _action;
    final playing = action != null && !_briefing;
    final suggestCell = playing && action.input == TutorialInput.cell;
    final suggestRow = playing && action.input == TutorialInput.row;
    final suggestColumn = playing && action.input == TutorialInput.column;
    final suggestApply = playing && action.input == TutorialInput.apply;
    final briefAction = _briefAction;
    final guideKey = !_briefing || _locked || _done || briefAction == null
        ? null
        : _targetKey(briefAction);
    final guideRect = guideKey == null ? null : _guideRectFor(guideKey);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        title: Text(
          l10n.tutorialTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1F3A),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _close,
        ),
      ),
      body: SafeArea(
        child: Stack(
          key: _guideStackKey,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              child: Column(
                children: [
                  _buildGoal(),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AnimatedBuilder(
                          animation: _shake,
                          builder: (context, child) {
                            final t = _shake.value;
                            final dx = math.sin(t * math.pi * 5) * 8 * (1 - t);
                            return Transform.translate(
                              offset: Offset(dx, 0),
                              child: child,
                            );
                          },
                          child: BoardWidget(
                            board: _board,
                            cellSize: 42,
                            customKeys: _boardKeys,
                            selectedPositions: _selectedPositions,
                            highlightedPositions: _highlight,
                            suggestedPositions: suggestCell
                                ? _suggestedCells(action)
                                : const [],
                            suggestedRows:
                                suggestRow ? {action.row: true} : null,
                            suggestedColumns:
                                suggestColumn ? {action.col: true} : null,
                            enableRowColumnButtons: true,
                            selectedGate: _selectedGate,
                            selectedRows: _selectedRow != null
                                ? {_selectedRow!: true}
                                : const {},
                            selectedColumns: _selectedColumn != null
                                ? {_selectedColumn!: true}
                                : const {},
                            onPositionTap: _onCell,
                            onRowSelected: (row, _) => _onRow(row),
                            onColumnSelected: (col, _) => _onColumn(col),
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 8),
              ValueListenableBuilder<bool>(
                valueListenable: GateEffectIconSetting.instance.notifier,
                builder: (context, showIcons, _) {
                  final oneRows = showIcons
                      ? chunkGateRows(_oneBitGates, 2)
                      : [_oneBitGates];
                  return Column(
                    children: [
                      for (final row in oneRows) ...[
                        _buildGateRow(row, showIcons: showIcons),
                        const SizedBox(height: 8),
                      ],
                      _buildGateRow(_twoBitGates, showIcons: showIcons),
                    ],
                  );
                },
              ),
                  const SizedBox(height: 8),
                  if (!_done && _introStep == null)
                    Text(
                      _statusText(l10n),
                      style: const TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(height: 12),
                  if (!_done) _buildApplyButton(suggestApply),
                ],
              ),
            ),
            if (_done)
              Positioned.fill(
                child: _TutorialCompletePopup(onDismiss: _returnToModeSelect),
              )
            else if (_showClear)
              Positioned.fill(
                child: _TutorialClearPopup(
                  detail: _clearDetail,
                  onDismiss: _skipClear,
                ),
              )
            else if (_introStep != null)
              Positioned.fill(
                child: TutorialStepGuide(
                  heading: l10n.tutorialIntroConcept,
                  message: l10n.tutorialIntroHowTo,
                  nextLabel: l10n.tutorialStartOperating,
                  onNext: _nextIntro,
                ),
              )
            else if (guideRect != null)
              Positioned.fill(
                child: TutorialStepGuide(
                  targetRect: guideRect,
                  message: _briefText(l10n, briefAction?.brief),
                  nextLabel: _briefStep >= _explainIndexes().length - 1
                      ? l10n.tutorialStartOperating
                      : l10n.next,
                  onNext: _nextBrief,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoal() {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _done
                    ? l10n.tutorialComplete
                    : _topicTitle(l10n, _puzzle.topic),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              _done ? '' : '${_puzzleIndex + 1}/${_puzzles.length}',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        if (!_done) ...[
          const SizedBox(height: 4),
          Text(
            l10n.tutorialGoalLabel(_goalLabel(l10n, _puzzle.goalType)),
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ],
    );
  }

  Widget _buildGateRow(List<GateType> gates, {required bool showIcons}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = 8.0;
        final preferred = showIcons
            ? gates
                .map(
                  (gate) => GateButtonGrid.preferredWidth(
                    gate,
                    showEffectIcon: true,
                  ),
                )
                .reduce(math.max)
            : 64.0;
        final available = constraints.maxWidth.isFinite
            ? (constraints.maxWidth - gap * (gates.length - 1)) / gates.length
            : preferred;
        final width =
            showIcons ? math.min(preferred, math.max(0.0, available)) : 64.0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < gates.length; i++) ...[
              if (i > 0) const SizedBox(width: gap),
              SizedBox(
                key: _gateKeys[gates[i]],
                width: width,
                child: showIcons
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: _buildGateButton(gates[i], showIcons: true),
                      )
                    : _buildGateButton(gates[i], showIcons: false),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildGateButton(GateType gate, {required bool showIcons}) {
    final action = _action;
    final isTarget =
        action?.input == TutorialInput.gate && action?.gate == gate;
    final isSelected = _selectedGate == gate;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final glow = isTarget && !_locked && !_briefing && _introStep == null;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: glow
                  ? Colors.white
                      .withValues(alpha: 0.35 + _pulse.value * 0.65)
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: child,
        );
      },
      child: GateButton(
        gate: gate,
        isEnabled: isTarget || isSelected,
        isSelected: isSelected,
        showEffectIcon: showIcons,
        onTap: () => _onGate(gate),
      ),
    );
  }

  Widget _buildApplyButton(bool suggest) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) {
        final glow = suggest && !_locked && !_briefing;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: glow
                  ? Colors.white.withValues(alpha: 0.35 + _pulse.value * 0.65)
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: child,
        );
      },
      child: ElevatedButton(
        key: _applyKey,
        onPressed: suggest && !_locked ? _onApply : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          backgroundColor:
              suggest ? const Color(0xFF4CAF50) : Colors.grey.shade700,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade700,
          disabledForegroundColor: Colors.white70,
        ),
        child: Text(
          AppLocalizations.of(context).applyGate,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _TutorialClearPopup extends StatelessWidget {
  const _TutorialClearPopup({
    required this.onDismiss,
    this.detail,
  });

  final VoidCallback onDismiss;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final note = detail;
    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.opaque,
      child: ColoredBox(
        color: Colors.black54,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFF2A3158),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.tutorialClear,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (note != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        note,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TutorialCompletePopup extends StatelessWidget {
  const _TutorialCompletePopup({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.opaque,
      child: ColoredBox(
        color: Colors.black54,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color(0xFF2A3158),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 22, 24, 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.tutorialComplete,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.tutorialReturnToModeSelect,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
