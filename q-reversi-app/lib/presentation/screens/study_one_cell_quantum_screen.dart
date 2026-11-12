import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/quantum/qcomplex.dart';
import '../../core/quantum/study_quantum_gauge.dart';
import '../../core/background_music.dart';
import '../../core/sound_effects.dart';
import '../../domain/entities/gate_type.dart';
import '../../domain/entities/piece.dart';
import '../../domain/entities/piece_type.dart';
import '../../domain/entities/position.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/content/study_content.dart';
import '../widgets/piece_widget.dart';
import '../widgets/study/bloch_sphere_widget.dart';
import '../widgets/study/study_quantum_graph_widgets.dart';
import '../widgets/study/study_text_tutorial_overlay.dart';
import '../gate_effect_icon_setting.dart';
import '../widgets/gate_button.dart';
import '../widgets/gate_button_grid.dart';
import '../widgets/sound_back_button.dart';
import '../../domain/services/study_text_progress_service.dart';

/// スタディ1: 1マスで学ぶ量子コンピュータ
class StudyOneCellQuantumScreen extends StatefulWidget {
  const StudyOneCellQuantumScreen({super.key});

  @override
  State<StudyOneCellQuantumScreen> createState() =>
      _StudyOneCellQuantumScreenState();
}

class _StudyOneCellQuantumScreenState extends State<StudyOneCellQuantumScreen>
    with TickerProviderStateMixin {
  static const Duration _rotationDuration = Duration(milliseconds: 600);
  static const double _initialYaw = -0.5;
  static const double _yawPerPixel = 0.006;
  static const List<GateType> _oneBitGates = [
    GateType.x,
    GateType.h,
    GateType.y,
    GateType.z,
  ];

  static const List<String> _basisLabelsOne = ['|0⟩', '|1⟩'];

  late final AnimationController _rotationController;
  late final TabController _upperTabController;
  GateType? _selectedGate;
  GateType? _applyingGate;
  PieceType _pieceType = PieceType.white;
  PieceType? _targetPieceType;
  double _yaw = _initialYaw;
  final GlobalKey _blochAreaKey = GlobalKey();
  final GlobalKey _upperHalfAreaKey = GlobalKey();
  final GlobalKey _amplitudeTabKey = GlobalKey();
  final GlobalKey _amplitudeGraphKey = GlobalKey();
  final GlobalKey _probabilityGraphKey = GlobalKey();
  int? _tutorialStepIndex;
  bool _isTutorialAutoMode = false;
  bool _hasAppliedAnyGate = false;
  bool _waitingGateApply = false;
  bool _waitingAmplitudeTabTap = false;
  late List<StudyTextTutorialStep> _tutorialSteps;
  late final BgmHandle _bgm;

  /// ステップ index / ターゲットキー / ボタンラベルはロケールに依存しない。
  /// 文言のみ [StudyContent] から取得する。
  List<StudyTextTutorialStep> _buildTutorialSteps(
    StudyContent content,
    AppLocalizations l10n,
  ) {
    final t = content.oneCellSteps;
    return [
      StudyTextTutorialStep(
        title: t[0].title,
        message: t[0].message,
      ),
      StudyTextTutorialStep(
        title: t[1].title,
        targetKey: _upperHalfAreaKey,
        message: t[1].message,
      ),
      StudyTextTutorialStep(
        title: t[2].title,
        message: t[2].message,
      ),
      StudyTextTutorialStep(
        title: t[3].title,
        targetKey: _amplitudeTabKey,
        message: t[3].message,
        highlightExpandX: 10,
      ),
      StudyTextTutorialStep(
        title: t[4].title,
        targetKey: _amplitudeGraphKey,
        message: t[4].message,
      ),
      StudyTextTutorialStep(
        title: t[5].title,
        targetKey: _probabilityGraphKey,
        message: t[5].message,
        nextLabel: l10n.done,
      ),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tutorialSteps = _buildTutorialSteps(
      StudyContent.ofContext(context),
      AppLocalizations.of(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _bgm = BgmHandle.hold(Bgm.study);
    _upperTabController = TabController(length: 2, vsync: this);
    _upperTabController.addListener(() {
      if (_upperTabController.indexIsChanging) return;
      if (_waitingAmplitudeTabTap && _upperTabController.index == 1) {
        _waitingAmplitudeTabTap = false;
        _openAmplitudeTutorialStep();
      }
    });
    _rotationController = AnimationController(
      vsync: this,
      duration: _rotationDuration,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _pieceType = _targetPieceType ?? _pieceType;
            _targetPieceType = null;
            _selectedGate = null;
            _applyingGate = null;
            _hasAppliedAnyGate = true;
          });
          if (_waitingGateApply) {
            setState(() {
              _hasAppliedAnyGate = true;
              _waitingGateApply = false;
              _tutorialStepIndex = 2;
            });
          }
          _rotationController.reset();
        }
      });
    _showTutorialOnFirstVisit();
  }

  @override
  void dispose() {
    _bgm.release();
    _upperTabController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  bool get _isAnimating => _rotationController.isAnimating;
  GateType? get _effectiveGate => _applyingGate ?? _selectedGate;

  BlochVector get _startVector => _pieceTypeToBlochVector(_pieceType);
  BlochVector get _displayVector {
    if (!_isAnimating || _applyingGate == null) {
      return _startVector;
    }
    final axis = _axisDirection(_gateToAxis(_applyingGate));
    if (axis == null) {
      return _startVector;
    }
    final theta = math.pi * _rotationController.value;
    return _rotateAroundAxis(_startVector, axis, theta).normalized();
  }

  void _onSelectGate(GateType gate) {
    if (_isAnimating) return;
    SoundEffects.instance.gateSelect();
    setState(() {
      _selectedGate = gate;
    });
  }

  Future<void> _applySelectedGate() async {
    final gate = _selectedGate;
    if (gate == null || _isAnimating) return;
    SoundEffects.instance.apply();

    final target = _applyOneBitGate(_pieceType, gate);
    setState(() {
      _applyingGate = gate;
      _targetPieceType = target;
    });
    await _rotationController.forward(from: 0);
  }

  Future<void> _showTutorialOnFirstVisit() async {
    final seen = await StudyTextProgressService.hasSeen('study1');
    if (!mounted || seen) return;
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _startTutorial(autoMode: true);
  }

  void _openAmplitudeTutorialStep() {
    setState(() {
      _tutorialStepIndex = 4;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _tutorialStepIndex != 4) return;
      // タブ切替直後はグラフカードのレイアウトが未確定なことがあるため、次フレームで再評価する。
      setState(() {
        _tutorialStepIndex = 4;
      });
    });
  }

  void _startTutorial({required bool autoMode}) {
    if (!autoMode) SoundEffects.instance.click();
    final startIndex = (!autoMode && _upperTabController.index == 1) ? 4 : 0;
    setState(() {
      _isTutorialAutoMode = autoMode;
      _tutorialStepIndex = startIndex;
      _waitingGateApply = false;
      _waitingAmplitudeTabTap = false;
      if (autoMode) {
        _hasAppliedAnyGate = false;
      }
    });
    if (startIndex == 4) {
      _openAmplitudeTutorialStep();
    }
  }

  void _closeTutorial() {
    final wasAuto = _isTutorialAutoMode;
    setState(() {
      _tutorialStepIndex = null;
      _waitingGateApply = false;
      _waitingAmplitudeTabTap = false;
      _isTutorialAutoMode = false;
    });
    if (wasAuto) {
      StudyTextProgressService.markSeen('study1');
    }
  }

  void _advanceTutorial({bool forceNext = false}) {
    final index = _tutorialStepIndex;
    if (index == null) return;
    if (!forceNext) {
      if (index == 1 && !_hasAppliedAnyGate) {
        setState(() {
          _waitingGateApply = true;
          _tutorialStepIndex = null;
        });
        return;
      }
      if (index == 3 && _upperTabController.index != 1) {
        setState(() {
          _waitingAmplitudeTabTap = true;
          _tutorialStepIndex = null;
        });
        return;
      }
    }
    if (index >= _tutorialSteps.length - 1) {
      _closeTutorial();
      return;
    }
    setState(() {
      _tutorialStepIndex = index + 1;
    });
  }

  void _onHorizontalDrag(double deltaDx) {
    setState(() {
      _yaw += deltaDx * _yawPerPixel;
    });
  }

  BlochVector? _axisDirection(BlochAxis? axis) {
    switch (axis) {
      case BlochAxis.x:
        return const BlochVector(x: 1, y: 0, z: 0);
      case BlochAxis.y:
        return const BlochVector(x: 0, y: 1, z: 0);
      case BlochAxis.z:
        return const BlochVector(x: 0, y: 0, z: 1);
      case BlochAxis.h:
        return const BlochVector(
          x: 0,
          y: 0.7071067811865476,
          z: 0.7071067811865476,
        );
      default:
        return null;
    }
  }

  BlochVector _rotateAroundAxis(
    BlochVector v,
    BlochVector axis,
    double theta,
  ) {
    final k = axis.normalized();
    final cosT = math.cos(theta);
    final sinT = math.sin(theta);

    final kCrossV = BlochVector(
      x: k.y * v.z - k.z * v.y,
      y: k.z * v.x - k.x * v.z,
      z: k.x * v.y - k.y * v.x,
    );
    final kDotV = k.x * v.x + k.y * v.y + k.z * v.z;

    return BlochVector(
      x: v.x * cosT + kCrossV.x * sinT + k.x * kDotV * (1 - cosT),
      y: v.y * cosT + kCrossV.y * sinT + k.y * kDotV * (1 - cosT),
      z: v.z * cosT + kCrossV.z * sinT + k.z * kDotV * (1 - cosT),
    );
  }

  PieceType _applyOneBitGate(PieceType pieceType, GateType gate) {
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

  BlochVector _pieceTypeToBlochVector(PieceType type) {
    switch (type) {
      case PieceType.white:
        return const BlochVector(x: 0, y: 1, z: 0); // |0⟩ 上向き
      case PieceType.black:
        return const BlochVector(x: 0, y: -1, z: 0); // |1⟩ 下向き
      case PieceType.grayPlus:
        return const BlochVector(x: 0, y: 0, z: 1); // |+⟩（Xラベル方向）
      case PieceType.grayMinus:
        return const BlochVector(x: 0, y: 0, z: -1); // |-⟩（反対方向）
      default:
        return const BlochVector(x: 0, y: 1, z: 0);
    }
  }

  BlochAxis? _gateToAxis(GateType? gate) {
    switch (gate) {
      case GateType.x:
        return BlochAxis.z;
      case GateType.y:
        return BlochAxis.x;
      case GateType.z:
        return BlochAxis.y;
      case GateType.h:
        return BlochAxis.h;
      default:
        return null;
    }
  }

  BlochAxis? _gateToHighlightAxis(GateType? gate) {
    switch (gate) {
      case GateType.x:
        return BlochAxis.x;
      case GateType.y:
        return BlochAxis.y;
      case GateType.z:
        return BlochAxis.z;
      case GateType.h:
        return BlochAxis.h;
      default:
        return null;
    }
  }

  BlochAxis? _gateToLineHighlightAxis(GateType? gate) {
    switch (gate) {
      case GateType.x:
        return BlochAxis.z;
      case GateType.y:
        return BlochAxis.x;
      case GateType.z:
        return BlochAxis.y;
      case GateType.h:
        return BlochAxis.h;
      default:
        return null;
    }
  }

  String _stateLabel(AppLocalizations l10n, PieceType type) {
    switch (type) {
      case PieceType.white:
        return l10n.studyStateWhite;
      case PieceType.black:
        return l10n.studyStateBlack;
      case PieceType.grayPlus:
        return l10n.studyStateGrayPlus;
      case PieceType.grayMinus:
        return l10n.studyStateGrayMinus;
      default:
        return l10n.studyStateUnsupported;
    }
  }

  /// 計算基底（|0⟩=+y）での複素振幅 [α0, α1]。
  ///
  /// 画面の Bloch ベクトル (vx, vy, vz) は、表示を変えずに標準の
  /// (nx, ny, nz) へ **ny↔vx, nz↔vy, nx↔vz** と対応する座標系（|0⟩が+y、|+⟩が+z 等）とみなす。
  /// よって教科書の |ψ⟩=cos(θ/2)|0⟩+e^{iφ}sin(θ/2)|1⟩ では
  /// φ=atan2(ny,nx)=**atan2(vx, vz)**。αを実数に取る慣用のもと
  /// β=√p1·e^{iφ}（p0=(1+vy)/2）。**atan2(vz,vx) だと |+⟩ が (|0⟩+i|1⟩)/√2 になって誤る**。
  List<QComplex> _complexAmplitudes01(BlochVector raw) {
    final v = raw.normalized();
    final p0 = ((1.0 + v.y) * 0.5).clamp(0.0, 1.0);
    final p1 = (1.0 - p0).clamp(0.0, 1.0);
    final r0 = math.sqrt(p0);
    final r1 = math.sqrt(p1);
    final r = math.sqrt(v.x * v.x + v.z * v.z);

    if (r1 < 1e-12) {
      return [QComplex(r0, 0), QComplex.zero];
    }
    if (r0 < 1e-12) {
      final phi = math.atan2(v.x, v.z);
      return [QComplex.zero, QComplex.polar(r1, phi)];
    }
    if (r < 1e-12) {
      return [QComplex(r0, 0), QComplex.zero];
    }
    final phi = math.atan2(v.x, v.z);
    return [QComplex(r0, 0), QComplex.polar(r1, phi)];
  }

  Widget _buildAmplitudeGraphTab(BlochVector v) {
    final l10n = AppLocalizations.of(context);
    final cpx = globalPhaseGaugeFirstPositive(_complexAmplitudes01(v));
    final amps = cpx.map((z) => z.re).toList();
    final probs = cpx.map((z) => z.normSquared().clamp(0.0, 1.0)).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
      child: Column(
        children: [
          Expanded(
            child: Container(
              key: _amplitudeGraphKey,
              child: StudyQuantumGraphCard(
                title: l10n.studyAmplitudeChartTitle,
                child: StudyQuantumStateBarChart(
                  values: amps,
                  labels: _basisLabelsOne,
                  minY: -1,
                  maxY: 1,
                  barColor: const Color(0xFF57D6FF),
                  zeroLineColor: const Color(0xFF9AA3C1),
                  valueFormatter: (x) => x.toStringAsFixed(2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              key: _probabilityGraphKey,
              child: StudyQuantumGraphCard(
                title: l10n.studyProbabilityChartTitle,
                child: StudyQuantumStateBarChart(
                  values: probs,
                  labels: _basisLabelsOne,
                  minY: 0,
                  maxY: 1,
                  barColor: const Color(0xFF9C6BFF),
                  zeroLineColor: const Color(0xFF9AA3C1),
                  valueFormatter: (x) => x.toStringAsFixed(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final piece = Piece(
      id: 'study_one_cell',
      type: _pieceType,
      position: const Position(0, 0),
    );
    final highlightedAxisLabel = _gateToHighlightAxis(_effectiveGate);
    final highlightedAxisLine = _gateToLineHighlightAxis(_effectiveGate);

    final tutorialIndex = _tutorialStepIndex;
    final currentStep =
        tutorialIndex == null ? null : _tutorialSteps[tutorialIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.studyOneCellTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1F3A),
        foregroundColor: Colors.white,
        leading: const SoundBackButton(),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A0E27),
                  Color(0xFF1A1F3A),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      key: _upperHalfAreaKey,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                        child: Column(
                          children: [
                            TabBar(
                              controller: _upperTabController,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white54,
                              indicatorColor: const Color(0xFF9C6BFF),
                              tabs: [
                                Tab(text: l10n.studyTabBlochSphere),
                                Tab(
                                  key: _amplitudeTabKey,
                                  text: l10n.studyTabAmplitude,
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _upperTabController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  LayoutBuilder(
                                    key: _blochAreaKey,
                                    builder: (context, constraints) {
                                      final sphereFromHeight =
                                          constraints.maxHeight * 0.92;
                                      final sphereSide = sphereFromHeight <=
                                              constraints.maxWidth * 0.95
                                          ? sphereFromHeight
                                          : constraints.maxWidth * 0.95;
                                      return AnimatedBuilder(
                                        animation: _rotationController,
                                        builder: (context, _) {
                                          return Center(
                                            child: SizedBox(
                                              width: sphereSide,
                                              height: sphereSide,
                                              child: GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onHorizontalDragUpdate:
                                                    (details) {
                                                  _onHorizontalDrag(
                                                      details.delta.dx);
                                                },
                                                child: BlochSphereWidget(
                                                  startVector: _displayVector,
                                                  endVector: _displayVector,
                                                  progress: 0,
                                                  highlightedAxisLine:
                                                      highlightedAxisLine,
                                                  highlightedAxisLabel:
                                                      highlightedAxisLabel,
                                                  yaw: _yaw,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  AnimatedBuilder(
                                    animation: _rotationController,
                                    builder: (context, _) {
                                      return _buildAmplitudeGraphTab(
                                          _displayVector);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E132B).withValues(alpha: 0.6),
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.12),
                            width: 1,
                          ),
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) =>
                            SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: constraints.maxHeight),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Spacer(),
                                    OutlinedButton(
                                      onPressed: () =>
                                          _startTutorial(autoMode: false),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        side: BorderSide(
                                          color: Colors.white
                                              .withValues(alpha: 0.45),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                      ),
                                      child: Text(l10n.studyTextButton),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.studyCurrentState(
                                      _stateLabel(l10n, _pieceType)),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2E7D32),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFF5BAE62),
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: PieceWidget(
                                      piece: piece,
                                      size: 72,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                ValueListenableBuilder<bool>(
                                  valueListenable:
                                      GateEffectIconSetting.instance.notifier,
                                  builder: (context, showIcons, _) {
                                    final rows = showIcons
                                        ? chunkGateRows(_oneBitGates, 2)
                                        : [_oneBitGates];
                                    return GateButtonGrid(
                                      rows: rows,
                                      showEffectIcon: showIcons,
                                      itemBuilder: (gate) => GateButton(
                                        gate: gate,
                                        isEnabled: !_isAnimating,
                                        isSelected: _selectedGate == gate,
                                        showEffectIcon: showIcons,
                                        onTap: () {
                                          _onSelectGate(gate);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed:
                                      (_selectedGate == null || _isAnimating)
                                          ? null
                                          : _applySelectedGate,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    backgroundColor:
                                        (_selectedGate == null || _isAnimating)
                                            ? Colors.grey.shade700
                                            : const Color(0xFF4CAF50),
                                    foregroundColor: Colors.white,
                                  ),
                                  child: Text(
                                    _isAnimating
                                        ? l10n.studyApplying
                                        : l10n.applyGate,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (currentStep != null)
            StudyTextTutorialOverlay(
              step: currentStep,
              onNext: _advanceTutorial,
              onClose: _closeTutorial,
            ),
        ],
      ),
    );
  }
}
