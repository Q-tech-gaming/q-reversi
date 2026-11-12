// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Q-Reversi';

  @override
  String appVersionLabel(String version) {
    return 'v$version';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get retry => 'Retry';

  @override
  String get tryAgain => 'Try again';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get ok => 'OK';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get done => 'Done';

  @override
  String get exit => 'Exit';

  @override
  String get back => 'Back';

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteAction => 'Delete';

  @override
  String get settings => 'Settings';

  @override
  String get skip => 'Skip';

  @override
  String get understood => 'Got it';

  @override
  String get startOver => 'Start over';

  @override
  String get later => 'Later';

  @override
  String get loading => 'Loading…';

  @override
  String get refresh => 'Refresh';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get helpAndInfo => 'Help & Info';

  @override
  String pageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get pieceWhite => 'White';

  @override
  String get pieceBlack => 'Black';

  @override
  String get whiteScoreLabel => 'White: ';

  @override
  String get blackScoreLabel => 'Black: ';

  @override
  String get playerLabelPrefix => 'Player: ';

  @override
  String playerLabel(String label) {
    return 'Player: $label';
  }

  @override
  String turnCounterOfMax(int turn, int maxTurns) {
    return 'Turn: $turn/$maxTurns';
  }

  @override
  String turnsCount(int n) {
    return 'Turns: $n';
  }

  @override
  String goalLabel(String goal) {
    return 'Goal: $goal';
  }

  @override
  String optimalTurnsLabel(int n) {
    return 'Best: $n turns';
  }

  @override
  String levelTitle(String label) {
    return 'Level $label';
  }

  @override
  String stageLabel(int n) {
    return 'Stage $n';
  }

  @override
  String get cpuThinking => 'CPU is thinking…';

  @override
  String get victoryAllWhite => 'Turn every piece white';

  @override
  String get victoryAllBlack => 'Turn every piece black';

  @override
  String get difficultyBeginner => 'Beginner';

  @override
  String get difficultyIntermediate => 'Intermediate';

  @override
  String get difficultyAdvanced => 'Advanced';

  @override
  String get difficultyQuantumAi => 'Quantum AI';

  @override
  String get homeStart => 'START';

  @override
  String get modeTutorialTitle => 'Tutorial';

  @override
  String get modeTutorialSubtitle => 'How to play';

  @override
  String get modeChallengeTitle => 'Challenge Mode';

  @override
  String get modeChallengeSubtitle => 'Create target quantum states in puzzles';

  @override
  String get modeTimeAttackTitle => 'Time Attack Mode';

  @override
  String get modeTimeAttackSubtitle =>
      'Beat the clock and climb the leaderboard';

  @override
  String get modeVsTitle => 'VS Mode';

  @override
  String get modeVsSubtitle => 'Play against a friend or the CPU';

  @override
  String get modeFreeRunTitle => 'Free Run Mode';

  @override
  String get modeFreeRunSubtitle => 'Experiment freely with quantum gates';

  @override
  String get modeStudyTitle => 'Study Mode';

  @override
  String get modeStudySubtitle => 'Get a feel for quantum computing';

  @override
  String get modeUnlockByChallengeStage0 =>
      'Clear Challenge Mode Stage 0 to unlock this mode';

  @override
  String get modeRequiresTutorial => 'Finish or skip the tutorial first';

  @override
  String get resumeBattleTitle => 'Continue match?';

  @override
  String get resumeBattleMessage => 'Pick up where you left off?';

  @override
  String get vsSetupTitle => 'VS Mode';

  @override
  String get vsCpuDifficultyHeading => 'CPU Difficulty';

  @override
  String get vsDifficultyUnlockNote =>
      'Win at each difficulty to unlock the next.';

  @override
  String get vsDifficultyColumn => 'Difficulty';

  @override
  String get vsRecordColumn => 'Record';

  @override
  String get vsLegendLoss => 'L';

  @override
  String get vsLegendDraw => 'D';

  @override
  String get vsLegendWin => 'W';

  @override
  String vsRecordSummary(int wins, int played) {
    return '${wins}W / $played played';
  }

  @override
  String get vsQuantumAiDescription =>
      'An AI trained with quantum machine learning';

  @override
  String get vsBattleModeHeading => 'Match type';

  @override
  String get vsModeVsCpu => 'vs CPU';

  @override
  String get vsModeVsHuman => 'vs Human';

  @override
  String get vsVsHumanLocked => 'Play one vs CPU match to unlock';

  @override
  String get vsTurnsHeading => 'Turns';

  @override
  String get vsTurnsLockedNote =>
      'Starts locked at 20 turns. Play one vs CPU match to unlock other options.';

  @override
  String vsTurnsOption(int turns) {
    return '$turns turns';
  }

  @override
  String get vsStartGame => 'Start';

  @override
  String get vsQuantumAiRanking => 'VS Quantum AI RANKING';

  @override
  String get challengeModeTitle => 'Challenge Mode';

  @override
  String get challengeNoLevels => 'No levels available';

  @override
  String challengeStageProgress(int done, int total) {
    return '$done / $total cleared';
  }

  @override
  String challengeStageProgressUnlock(int done, int total) {
    return '$done / $total cleared\nClear every stage to unlock more modes';
  }

  @override
  String get challengeGuideStep1 =>
      '1. Check the clear condition.\nTurn the whole board white or black to clear the level.';

  @override
  String get challengeGuideStep2 => '2. Choose a gate';

  @override
  String get challengeGuideStep3 =>
      '3. Choose the pieces to affect.\nTap a cell on the board, or a button beside it.';

  @override
  String get challengeGuideStep4 =>
      '4. Tap Apply Gate to use it on those pieces';

  @override
  String get challengeGuideStep5 =>
      '5. You can review gate effects anytime with this info button';

  @override
  String get challengeAvailableGates => 'Available gates';

  @override
  String get challengeLevelClearTitle => '🎉 Level cleared!';

  @override
  String challengeLevelClearMessage(String label) {
    return 'Level $label cleared!';
  }

  @override
  String challengeTurnsUsed(int n) {
    return 'Turns used: $n';
  }

  @override
  String get applyGate => 'Apply Gate';

  @override
  String get reset => 'Reset';

  @override
  String get measure => 'Measure';

  @override
  String get gateEffectsTitle => 'Gate Effects';

  @override
  String get gateEffectsTooltip => 'Gate effects';

  @override
  String get gateEffectPage1 => 'Gate effects ①';

  @override
  String get gateEffectPage2 => 'Gate effects ②';

  @override
  String get gateEffectNonCnot => 'Gate effects (non-CNOT)';

  @override
  String get gateEffectCnotWhitePlayer => 'CNOT [White player]';

  @override
  String get gateEffectCnotBlackPlayer => 'CNOT [Black player]';

  @override
  String get hintSelectGateOrBoard => 'Choose a gate or a target on the board';

  @override
  String get hintSelectGateFirst => 'Choose a gate first';

  @override
  String get hintSelectFirstCell => 'Choose the first cell';

  @override
  String get hintSelectSecondCell => 'Choose the second cell';

  @override
  String get hintTwoCellsSelected => '2 cells selected';

  @override
  String get hintSelectRowColumnOrCell =>
      'Choose a row/column button or a cell';

  @override
  String get errorEntangledNotSelectable =>
      'You can\'t select entangled pieces';

  @override
  String get errorAdjacentOnly => 'Choose adjacent pieces only';

  @override
  String get errorRegionContainsEntangled =>
      'That area includes entangled pieces';

  @override
  String get errorRangeContainsEntangled =>
      'That selection includes entangled pieces';

  @override
  String get errorGateApplyFailed => 'Couldn\'t apply the gate';

  @override
  String get errorGateApplyFailedForbidden =>
      'Couldn\'t apply the gate (forbidden area or entangled pieces)';

  @override
  String get errorForbiddenArea =>
      'That area is forbidden. You can\'t reuse the area your opponent used last turn.';

  @override
  String get errorSelectXFirst => 'Choose the X gate first.';

  @override
  String errorSelectBestTarget(String label) {
    return 'Choose $label — it gains you the most pieces';
  }

  @override
  String errorSelectBestTargetThenApply(String label) {
    return 'Choose $label, then apply';
  }

  @override
  String vsGuideRowLabel(int n) {
    return 'Row $n';
  }

  @override
  String vsGuideColumnLabel(int n) {
    return 'Column $n';
  }

  @override
  String vsGuideFourCellsLabel(int row, int col) {
    return 'the 4 cells near row $row, column $col';
  }

  @override
  String get vsGuideIntro =>
      'In VS Mode, you take turns applying gates and try to finish with more pieces.';

  @override
  String get vsGuideSelectX => 'First, choose the X gate';

  @override
  String vsGuideSelectBoard(String label, int netGain, int blackFlips) {
    return 'You\'ll gain the most pieces at $label (net +$netGain: $blackFlips black → white).\nTap the highlighted target';
  }

  @override
  String get vsGuideApply => 'Tap Apply Gate';

  @override
  String get vsGuideForbidden =>
      'Your opponent can\'t use the area you just played.\nIt stays forbidden on their turn.';

  @override
  String get vsGuideCooldown =>
      'Your turn.\nThe X gate you just used is on cooldown.';

  @override
  String get vsGuideGateStrength =>
      'A quick guide to gate strength.\nGates that flip more of your opponent\'s pieces to your colour are stronger.\nX / Y > H > CNOT > Z > SWAP';

  @override
  String get vsGuideInfo =>
      'You can check each gate\'s effect anytime with this info button.';

  @override
  String get vsGuideMeasure =>
      'You\'ve reached 20 turns.\nTap Run Measurement to decide the winner.';

  @override
  String get vsQuitTitle => 'Leave this match?';

  @override
  String get vsQuitMessage => 'Your board will be saved.';

  @override
  String get undoMove => 'Undo move';

  @override
  String get makeBoardAllWhite => 'Turn the whole board white';

  @override
  String get makeBoardAllBlack => 'Turn the whole board black';

  @override
  String get runMeasurement => 'Run Measurement';

  @override
  String get measureConfirmTitle => 'Ready to measure?';

  @override
  String get measureConfirmMessage => 'Measure now and show the result?';

  @override
  String get resultDraw => 'Draw';

  @override
  String get resultVictory => 'Victory!';

  @override
  String get resultDefeat => 'Defeat';

  @override
  String get resultWhiteWins => 'White wins!';

  @override
  String get resultBlackWins => 'Black wins!';

  @override
  String get resultBannerVictory => 'VICTORY';

  @override
  String get resultBannerDefeat => 'DEFEAT';

  @override
  String get resultBannerDraw => 'DRAW';

  @override
  String get resultBannerWinner => 'WINNER';

  @override
  String get matchResultBarrierLabel => 'Match result';

  @override
  String get resultYouWhite => 'You (White)';

  @override
  String get resultCpuBlack => 'CPU (Black)';

  @override
  String get resultViewResult => 'View result';

  @override
  String get resultGoToRanking => 'View ranking';

  @override
  String get timeAttackModeTitle => 'Time Attack Mode';

  @override
  String get timeAttackTitle => 'Time Attack';

  @override
  String get timeAttackHeroTitle => 'Time Attack\nChallenge';

  @override
  String get timeAttackIntro =>
      'You start with 30 seconds.\nClearing puzzles adds more TIME.';

  @override
  String get timeAttackComboHint =>
      'String PERFECTs together for a COMBO BONUS!';

  @override
  String get timeAttackNetworkRequired =>
      'An internet connection is required for Time Attack.';

  @override
  String get timeAttackStart => 'START';

  @override
  String get timeAttackRanking => 'RANKING';

  @override
  String get timeAttackDebugPreview => 'DEBUG PREVIEW';

  @override
  String get timeAttackDebugViewClear => 'View CLEAR screen';

  @override
  String get timeAttackDebugViewAllClear => 'View ALL CLEAR screen';

  @override
  String get timeAttackHudTime => 'TIME';

  @override
  String get timeAttackHudClear => 'CLEAR';

  @override
  String get timeAttackHudBestTurns => 'Best';

  @override
  String get timeAttackHudTurns => 'Turns';

  @override
  String get timeAttackHudCombo => 'COMBO';

  @override
  String get timeAttackAllClear => 'ALL CLEAR!';

  @override
  String get timeAttackPerfect => 'PERFECT!';

  @override
  String get timeAttackClear => 'CLEAR!';

  @override
  String timeAttackComboCount(int n) {
    return '$n COMBO';
  }

  @override
  String timeAttackBonusGained(int n) {
    return '+$n BONUS';
  }

  @override
  String timeAttackTimeBonus(String sec) {
    return 'TIME +$sec';
  }

  @override
  String get timeAttackNextLabel => 'NEXT';

  @override
  String get timeAttackQuitTitle => 'Quit?';

  @override
  String get timeAttackQuitMessage =>
      'Your current Time Attack run will be discarded.';

  @override
  String get timeAttackNewRecord => 'NEW RECORD!';

  @override
  String get timeAttackTotalScore => 'TOTAL SCORE';

  @override
  String get timeAttackClearBonus => 'CLEAR BONUS';

  @override
  String get timeAttackBonusHeading => 'BONUS';

  @override
  String get timeAttackMaxCombo => 'MAX COMBO';

  @override
  String get timeAttackComboBonus => 'COMBO BONUS';

  @override
  String get timeAttackTimeBonusLabel => 'TIME BONUS';

  @override
  String get timeAttackSubmitFailed => 'Couldn\'t submit your score';

  @override
  String get timeAttackNothingToResubmit => 'Nothing left to resubmit';

  @override
  String get timeAttackResubmit => 'Resubmit';

  @override
  String get timeAttackSubmitting => 'Submitting…';

  @override
  String get timeAttackViewRanking => 'View Ranking';

  @override
  String get timeAttackRankingInfoUnavailable => 'Couldn\'t load ranking info';

  @override
  String get timeAttackRankCalcFailed =>
      'Couldn\'t place this score on the ranking';

  @override
  String get rankingTitle => 'Ranking';

  @override
  String get rankingLoadFailed => 'Couldn\'t load the ranking';

  @override
  String get rankingYou => 'YOU';

  @override
  String get rankingNoRecordYet => 'No record yet';

  @override
  String get rankingNicknameColumn => 'Nickname';

  @override
  String get rankingWinsColumn => 'Wins';

  @override
  String rankingTotalScoreLine(int score) {
    return 'TOTAL SCORE  $score';
  }

  @override
  String get rankingClearCountLabel => 'Clears';

  @override
  String get rankingMaxCombo => 'MAX COMBO';

  @override
  String get rankingComboBonus => 'COMBO BONUS';

  @override
  String get rankingTimeBonus => 'TIME BONUS';

  @override
  String get rankingUpdatedAt => 'Updated';

  @override
  String get nicknameChangeTitle => 'Change name';

  @override
  String get nicknameHint => 'Nickname';

  @override
  String nicknameLengthError(int min, int max) {
    return 'Enter $min–$max characters';
  }

  @override
  String get nicknameTaken => 'That name is already taken';

  @override
  String get nicknameBlocked => 'That name includes a blocked word';

  @override
  String get nicknameSaveFailed => 'Couldn\'t save';

  @override
  String get playerNameTooltip => 'Player name';

  @override
  String get settingsFreeOrderTitle => 'Pick gates and pieces in any order';

  @override
  String get settingsFreeOrderDescription =>
      'When on, you can choose gates and pieces in any order.';

  @override
  String get settingsGateEffectIconTitle => 'Show effects on gate buttons';

  @override
  String get settingsGateEffectIconDescription =>
      'When on, each button shows how pieces change. When off, buttons show text only.';

  @override
  String get settingsDoubleTapTitle => 'Double-tap to apply instantly';

  @override
  String get settingsDoubleTapDescription =>
      'After choosing a gate, quickly tap the same piece twice to apply it right away. Tap the same row or column button again to apply it there without clearing your selection.';

  @override
  String get settingsVolumeHeading => 'Volume';

  @override
  String get settingsVolumeBgm => 'BGM';

  @override
  String get settingsVolumeSfx => 'Sound effects';

  @override
  String get legalPrivacyPolicy => 'Privacy Policy';

  @override
  String get legalSupport => 'Support';

  @override
  String get legalPrivacyPolicyUrl =>
      'https://q-tech-gaming.github.io/q-reversi-privacy-policy/en/';

  @override
  String get legalSupportUrl => 'https://q-tech-gaming.github.io/support/en/';

  @override
  String get legalDeleteRankingData => 'Delete ranking data';

  @override
  String get legalDeleteRankingDataSubtitle => 'Name, scores, wins, and more';

  @override
  String get legalCouldNotOpenPage => 'Couldn\'t open the page';

  @override
  String get legalDeleteDialogTitle => 'Delete ranking data';

  @override
  String get legalDeleteDialogBody =>
      'This deletes ranking data from the server and this device — including Time Attack records, VS Quantum AI wins, and your player name.\n\nChallenge progress and control settings stay. This can\'t be undone.';

  @override
  String get legalDeleteConfirmTitle => 'Delete for real?';

  @override
  String get legalDeleteConfirmBody =>
      'Cloud data and related data on this device will both be deleted.';

  @override
  String get legalDeleting => 'Deleting…';

  @override
  String get legalDeleteFailed => 'Couldn\'t delete ranking data';

  @override
  String get legalDeleteDoneTitle => 'Deleted';

  @override
  String get legalDeleteFailedTitle => 'Couldn\'t delete';

  @override
  String get legalDeleteDoneMessage => 'Your ranking data has been deleted.';

  @override
  String get tutorialTitle => 'Tutorial';

  @override
  String get tutorialComplete => 'Tutorial complete!';

  @override
  String get tutorialReturnToModeSelect => 'Heading back to mode select.';

  @override
  String get tutorialStartOperating => 'Try it';

  @override
  String get tutorialSelectGateButton => 'Choose a gate button.';

  @override
  String get tutorialIntroConcept =>
      'Q-Reversi mixes quantum computing with Reversi.';

  @override
  String get tutorialIntroHowTo =>
      'Let\'s learn the controls.\nTap the highlighted spot.';

  @override
  String tutorialGoalLabel(String goal) {
    return 'Goal: $goal';
  }

  @override
  String get tutorialStatusSelectFirstCell => 'Choose the first cell';

  @override
  String get tutorialStatusSelectSecondCell => 'Choose the second cell';

  @override
  String get tutorialStatusTwoCellsSelected => '2 cells selected';

  @override
  String get tutorialStatusSelectRowColumnOrCell =>
      'Choose a row/column button or a cell';

  @override
  String get tutorialTopicControls => 'Learn the controls';

  @override
  String get tutorialTopicHGate => 'Learn the H gate';

  @override
  String get tutorialTopicYGate => 'Learn the Y gate';

  @override
  String get tutorialTopicZGate => 'Learn the Z gate';

  @override
  String get tutorialTopicSwapGate => 'Learn the SWAP gate';

  @override
  String get tutorialTopicCnotGate => 'Learn the CNOT gate';

  @override
  String get tutorialHintSelectWholeRow =>
      'You can also select a whole row at once.';

  @override
  String get tutorialHintCnotBlackControl =>
      'If the first piece is black, the second piece changes.';

  @override
  String get tutorialUnderstood => 'Got it';

  @override
  String get pieceGrayPlus => 'Gray plus';

  @override
  String get pieceGrayMinus => 'Gray minus';

  @override
  String get tutorialImageNotFound => 'Image not found';

  @override
  String tutorialImageLoadError(String path, String error) {
    return 'Couldn\'t load image\n$path\n\nError: $error';
  }

  @override
  String get tutorialVideoPathMissing => 'No video path specified';

  @override
  String tutorialVideoLoadError(String path, String error) {
    return 'Couldn\'t load video\n$path\n\nError: $error';
  }

  @override
  String get tutorialDiagramLabel => 'Diagram';

  @override
  String get tutorialAnimationLabel => 'Animation';

  @override
  String get tutorialEntangledState => 'Entangled';

  @override
  String get tutorialCnotPatternNormal => 'Standard pattern';

  @override
  String get tutorialCnotPatternVsWhite => 'VS Mode · White player';

  @override
  String get tutorialPatternListPending => 'Pattern list (coming soon)';

  @override
  String get tutorialEntanglementResultWhite =>
      'Measured: White + White (entangled)';

  @override
  String get tutorialEntanglementResultBlack =>
      'Measured: Black + Black (entangled)';

  @override
  String get tutorialCnotGrayControlNote =>
      'Gray control bit: 50/50 white or black';

  @override
  String get tutorialClassicalComputer => 'Classical computer';

  @override
  String get tutorialQuantumComputer => 'Quantum computer';

  @override
  String get tutorialQReversi => 'Q-Reversi';

  @override
  String get tutorialDemoSelectGate => 'Choose a gate';

  @override
  String get tutorialDemoSelectColumn => 'Choose a column';

  @override
  String get tutorialDemoSelectRow => 'Choose a row';

  @override
  String get tutorialDemoSelectFourCells => 'Choose 4 cells';

  @override
  String get studyMenuTitle => 'Study Mode';

  @override
  String get studyMenuIntro => 'What is a quantum computer?';

  @override
  String get studyMenuOneCell => 'Quantum Computing\nin 1 Cell';

  @override
  String get studyMenuTwoCell => 'Quantum Computing\nin 2 Cells';

  @override
  String get studyMenuThreeCell => 'Grover\'s Algorithm\nin 3 Cells';

  @override
  String get studyMenuEpilogue => 'Epilogue';

  @override
  String get studyNavigationFailed => 'Couldn\'t open that screen';

  @override
  String get studyOneCellTitle => '1 Cell';

  @override
  String get studyTwoCellTitle => '2 Cells';

  @override
  String get studyThreeCellTitle => '3 Cells';

  @override
  String get studyTabBlochSphere => 'Bloch Sphere';

  @override
  String get studyTabAmplitude => 'Probability Amplitude';

  @override
  String get studyTextButton => 'Text';

  @override
  String studyCurrentState(String state) {
    return 'Current state: $state';
  }

  @override
  String get studyStateWhite => 'White piece |0⟩';

  @override
  String get studyStateBlack => 'Black piece |1⟩';

  @override
  String get studyStateGrayPlus => 'Gray plus |+⟩';

  @override
  String get studyStateGrayMinus => 'Gray minus |-⟩';

  @override
  String get studyStateUnsupported => 'N/A';

  @override
  String get studyAmplitudeChartTitle => 'Probability amplitude (-1 to 1)';

  @override
  String get studyProbabilityChartTitle => 'Probability (0 to 1)';

  @override
  String get studyApplying => 'Applying…';

  @override
  String get studyTwoCellHintSelectGate =>
      'Choose a gate, then pick where to apply it';

  @override
  String get studyTwoCellHintTwoBit =>
      'Tap two adjacent cells in order (control first, then target)';

  @override
  String get studyTwoCellHintOneBit =>
      'Tap a cell, or a side row button to select the whole row';

  @override
  String get studyGroverWrongStep => 'Wrong step. Tap Reset to start over.';

  @override
  String get studyGroverStepBroken =>
      'That broke the sequence. Tap Reset to start over.';

  @override
  String get studyGroverCircuitConsumed =>
      'All circuit steps are used. Measure to lock in the state.';

  @override
  String get studyGroverCircuitDone =>
      'Circuit complete. Tap Measure to lock in the state.';

  @override
  String get studyGroverChooseGate => 'Choose H, CCZ, or Diff.';

  @override
  String get studyGroverPressApply => 'Tap Apply Gate.';

  @override
  String studyGroverMeasureResult(String result) {
    return 'Measured: $result';
  }
}
