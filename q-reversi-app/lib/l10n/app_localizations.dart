import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Q-Reversi'**
  String get appTitle;

  /// Version label shown on the home screen. {version} is the app version string.
  ///
  /// In en, this message translates to:
  /// **'v{version}'**
  String appVersionLabel(String version);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Button to replay a run on the Time Attack result screen
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @understood.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get understood;

  /// No description provided for @startOver.
  ///
  /// In en, this message translates to:
  /// **'Start over'**
  String get startOver;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred'**
  String get errorOccurred;

  /// No description provided for @helpAndInfo.
  ///
  /// In en, this message translates to:
  /// **'Help & Info'**
  String get helpAndInfo;

  /// Page indicator. {current} is the 1-based current page, {total} the number of pages.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String pageCounter(int current, int total);

  /// No description provided for @pieceWhite.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get pieceWhite;

  /// No description provided for @pieceBlack.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get pieceBlack;

  /// Label before the white piece count (trailing space is intentional)
  ///
  /// In en, this message translates to:
  /// **'White: '**
  String get whiteScoreLabel;

  /// Label before the black piece count (trailing space is intentional)
  ///
  /// In en, this message translates to:
  /// **'Black: '**
  String get blackScoreLabel;

  /// Label before the current player's colour (trailing space is intentional)
  ///
  /// In en, this message translates to:
  /// **'Player: '**
  String get playerLabelPrefix;

  /// {label} is the player colour name
  ///
  /// In en, this message translates to:
  /// **'Player: {label}'**
  String playerLabel(String label);

  /// No description provided for @turnCounterOfMax.
  ///
  /// In en, this message translates to:
  /// **'Turn: {turn}/{maxTurns}'**
  String turnCounterOfMax(int turn, int maxTurns);

  /// No description provided for @turnsCount.
  ///
  /// In en, this message translates to:
  /// **'Turns: {n}'**
  String turnsCount(int n);

  /// {goal} is the goal / victory condition text
  ///
  /// In en, this message translates to:
  /// **'Goal: {goal}'**
  String goalLabel(String goal);

  /// No description provided for @optimalTurnsLabel.
  ///
  /// In en, this message translates to:
  /// **'Best: {n} turns'**
  String optimalTurnsLabel(int n);

  /// {label} is the level display label, e.g. 1-3
  ///
  /// In en, this message translates to:
  /// **'Level {label}'**
  String levelTitle(String label);

  /// No description provided for @stageLabel.
  ///
  /// In en, this message translates to:
  /// **'Stage {n}'**
  String stageLabel(int n);

  /// No description provided for @cpuThinking.
  ///
  /// In en, this message translates to:
  /// **'CPU is thinking…'**
  String get cpuThinking;

  /// Victory condition: turn the whole board white
  ///
  /// In en, this message translates to:
  /// **'Turn every piece white'**
  String get victoryAllWhite;

  /// Victory condition: turn the whole board black
  ///
  /// In en, this message translates to:
  /// **'Turn every piece black'**
  String get victoryAllBlack;

  /// No description provided for @difficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get difficultyBeginner;

  /// No description provided for @difficultyIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get difficultyIntermediate;

  /// No description provided for @difficultyAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get difficultyAdvanced;

  /// No description provided for @difficultyQuantumAi.
  ///
  /// In en, this message translates to:
  /// **'Quantum AI'**
  String get difficultyQuantumAi;

  /// No description provided for @homeStart.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get homeStart;

  /// No description provided for @modeTutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get modeTutorialTitle;

  /// No description provided for @modeTutorialSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How to play'**
  String get modeTutorialSubtitle;

  /// No description provided for @modeChallengeTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge Mode'**
  String get modeChallengeTitle;

  /// No description provided for @modeChallengeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create target quantum states in puzzles'**
  String get modeChallengeSubtitle;

  /// No description provided for @modeTimeAttackTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Attack Mode'**
  String get modeTimeAttackTitle;

  /// No description provided for @modeTimeAttackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Beat the clock and climb the leaderboard'**
  String get modeTimeAttackSubtitle;

  /// No description provided for @modeVsTitle.
  ///
  /// In en, this message translates to:
  /// **'VS Mode'**
  String get modeVsTitle;

  /// No description provided for @modeVsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Play against a friend or the CPU'**
  String get modeVsSubtitle;

  /// No description provided for @modeFreeRunTitle.
  ///
  /// In en, this message translates to:
  /// **'Free Run Mode'**
  String get modeFreeRunTitle;

  /// No description provided for @modeFreeRunSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Experiment freely with quantum gates'**
  String get modeFreeRunSubtitle;

  /// No description provided for @modeStudyTitle.
  ///
  /// In en, this message translates to:
  /// **'Study Mode'**
  String get modeStudyTitle;

  /// No description provided for @modeStudySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get a feel for quantum computing'**
  String get modeStudySubtitle;

  /// No description provided for @modeUnlockByChallengeStage0.
  ///
  /// In en, this message translates to:
  /// **'Clear Challenge Mode Stage 0 to unlock this mode'**
  String get modeUnlockByChallengeStage0;

  /// No description provided for @modeRequiresTutorial.
  ///
  /// In en, this message translates to:
  /// **'Finish or skip the tutorial first'**
  String get modeRequiresTutorial;

  /// No description provided for @resumeBattleTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue match?'**
  String get resumeBattleTitle;

  /// No description provided for @resumeBattleMessage.
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off?'**
  String get resumeBattleMessage;

  /// No description provided for @vsSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'VS Mode'**
  String get vsSetupTitle;

  /// No description provided for @vsCpuDifficultyHeading.
  ///
  /// In en, this message translates to:
  /// **'CPU Difficulty'**
  String get vsCpuDifficultyHeading;

  /// No description provided for @vsDifficultyUnlockNote.
  ///
  /// In en, this message translates to:
  /// **'Win at each difficulty to unlock the next.'**
  String get vsDifficultyUnlockNote;

  /// No description provided for @vsDifficultyColumn.
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get vsDifficultyColumn;

  /// No description provided for @vsRecordColumn.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get vsRecordColumn;

  /// Legend chip for losses in the record bar
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get vsLegendLoss;

  /// Legend chip for draws in the record bar
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get vsLegendDraw;

  /// Legend chip for wins in the record bar
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get vsLegendWin;

  /// {wins} wins out of {played} games played
  ///
  /// In en, this message translates to:
  /// **'{wins}W / {played} played'**
  String vsRecordSummary(int wins, int played);

  /// No description provided for @vsQuantumAiDescription.
  ///
  /// In en, this message translates to:
  /// **'An AI trained with quantum machine learning'**
  String get vsQuantumAiDescription;

  /// No description provided for @vsBattleModeHeading.
  ///
  /// In en, this message translates to:
  /// **'Match type'**
  String get vsBattleModeHeading;

  /// No description provided for @vsModeVsCpu.
  ///
  /// In en, this message translates to:
  /// **'vs CPU'**
  String get vsModeVsCpu;

  /// No description provided for @vsModeVsHuman.
  ///
  /// In en, this message translates to:
  /// **'vs Human'**
  String get vsModeVsHuman;

  /// No description provided for @vsVsHumanLocked.
  ///
  /// In en, this message translates to:
  /// **'Play one vs CPU match to unlock'**
  String get vsVsHumanLocked;

  /// No description provided for @vsTurnsHeading.
  ///
  /// In en, this message translates to:
  /// **'Turns'**
  String get vsTurnsHeading;

  /// No description provided for @vsTurnsLockedNote.
  ///
  /// In en, this message translates to:
  /// **'Starts locked at 20 turns. Play one vs CPU match to unlock other options.'**
  String get vsTurnsLockedNote;

  /// No description provided for @vsTurnsOption.
  ///
  /// In en, this message translates to:
  /// **'{turns} turns'**
  String vsTurnsOption(int turns);

  /// No description provided for @vsStartGame.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get vsStartGame;

  /// No description provided for @vsQuantumAiRanking.
  ///
  /// In en, this message translates to:
  /// **'VS Quantum AI RANKING'**
  String get vsQuantumAiRanking;

  /// No description provided for @challengeModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge Mode'**
  String get challengeModeTitle;

  /// No description provided for @challengeNoLevels.
  ///
  /// In en, this message translates to:
  /// **'No levels available'**
  String get challengeNoLevels;

  /// No description provided for @challengeStageProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total} cleared'**
  String challengeStageProgress(int done, int total);

  /// No description provided for @challengeStageProgressUnlock.
  ///
  /// In en, this message translates to:
  /// **'{done} / {total} cleared\nClear every stage to unlock more modes'**
  String challengeStageProgressUnlock(int done, int total);

  /// No description provided for @challengeGuideStep1.
  ///
  /// In en, this message translates to:
  /// **'Reach the goal in as few turns as you can!'**
  String get challengeGuideStep1;

  /// No description provided for @challengeAvailableGates.
  ///
  /// In en, this message translates to:
  /// **'Available gates'**
  String get challengeAvailableGates;

  /// No description provided for @challengeLevelClearTitle.
  ///
  /// In en, this message translates to:
  /// **'🎉 LEVEL CLEARED'**
  String get challengeLevelClearTitle;

  /// No description provided for @challengeLevelClearMessage.
  ///
  /// In en, this message translates to:
  /// **'Level {label}'**
  String challengeLevelClearMessage(String label);

  /// No description provided for @challengeTurnsUsed.
  ///
  /// In en, this message translates to:
  /// **'Turns used: {n}'**
  String challengeTurnsUsed(int n);

  /// No description provided for @applyGate.
  ///
  /// In en, this message translates to:
  /// **'Apply Gate'**
  String get applyGate;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @measure.
  ///
  /// In en, this message translates to:
  /// **'Measure'**
  String get measure;

  /// No description provided for @gateEffectsTitle.
  ///
  /// In en, this message translates to:
  /// **'Gate Effects'**
  String get gateEffectsTitle;

  /// No description provided for @gateEffectsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Gate effects'**
  String get gateEffectsTooltip;

  /// No description provided for @gateEffectPage1.
  ///
  /// In en, this message translates to:
  /// **'Gate effects ①'**
  String get gateEffectPage1;

  /// No description provided for @gateEffectPage2.
  ///
  /// In en, this message translates to:
  /// **'Gate effects ②'**
  String get gateEffectPage2;

  /// No description provided for @gateEffectNonCnot.
  ///
  /// In en, this message translates to:
  /// **'Gate effects (non-CNOT)'**
  String get gateEffectNonCnot;

  /// No description provided for @gateEffectCnotWhitePlayer.
  ///
  /// In en, this message translates to:
  /// **'CNOT [White player]'**
  String get gateEffectCnotWhitePlayer;

  /// No description provided for @gateEffectCnotBlackPlayer.
  ///
  /// In en, this message translates to:
  /// **'CNOT [Black player]'**
  String get gateEffectCnotBlackPlayer;

  /// No description provided for @hintSelectGateOrBoard.
  ///
  /// In en, this message translates to:
  /// **'Choose a gate or a target on the board'**
  String get hintSelectGateOrBoard;

  /// No description provided for @hintSelectGateFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose a gate first'**
  String get hintSelectGateFirst;

  /// No description provided for @hintSelectFirstCell.
  ///
  /// In en, this message translates to:
  /// **'Choose the first cell'**
  String get hintSelectFirstCell;

  /// No description provided for @hintSelectSecondCell.
  ///
  /// In en, this message translates to:
  /// **'Choose the second cell'**
  String get hintSelectSecondCell;

  /// No description provided for @hintTwoCellsSelected.
  ///
  /// In en, this message translates to:
  /// **'2 cells selected'**
  String get hintTwoCellsSelected;

  /// No description provided for @hintSelectRowColumnOrCell.
  ///
  /// In en, this message translates to:
  /// **'Choose a row/column button or a cell'**
  String get hintSelectRowColumnOrCell;

  /// No description provided for @errorEntangledNotSelectable.
  ///
  /// In en, this message translates to:
  /// **'You can\'t select entangled pieces'**
  String get errorEntangledNotSelectable;

  /// No description provided for @errorAdjacentOnly.
  ///
  /// In en, this message translates to:
  /// **'Choose adjacent pieces only'**
  String get errorAdjacentOnly;

  /// No description provided for @errorRegionContainsEntangled.
  ///
  /// In en, this message translates to:
  /// **'That area includes entangled pieces'**
  String get errorRegionContainsEntangled;

  /// No description provided for @errorRangeContainsEntangled.
  ///
  /// In en, this message translates to:
  /// **'That selection includes entangled pieces'**
  String get errorRangeContainsEntangled;

  /// No description provided for @errorGateApplyFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t apply the gate'**
  String get errorGateApplyFailed;

  /// No description provided for @errorGateApplyFailedForbidden.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t apply the gate (forbidden area or entangled pieces)'**
  String get errorGateApplyFailedForbidden;

  /// No description provided for @errorForbiddenArea.
  ///
  /// In en, this message translates to:
  /// **'That area is forbidden. You can\'t reuse the area your opponent used last turn.'**
  String get errorForbiddenArea;

  /// No description provided for @errorSelectXFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose the X gate first.'**
  String get errorSelectXFirst;

  /// No description provided for @errorSelectBestTarget.
  ///
  /// In en, this message translates to:
  /// **'Choose {label} — it gains you the most pieces'**
  String errorSelectBestTarget(String label);

  /// No description provided for @errorSelectBestTargetThenApply.
  ///
  /// In en, this message translates to:
  /// **'Choose {label}, then apply'**
  String errorSelectBestTargetThenApply(String label);

  /// No description provided for @vsGuideRowLabel.
  ///
  /// In en, this message translates to:
  /// **'Row {n}'**
  String vsGuideRowLabel(int n);

  /// No description provided for @vsGuideColumnLabel.
  ///
  /// In en, this message translates to:
  /// **'Column {n}'**
  String vsGuideColumnLabel(int n);

  /// No description provided for @vsGuideFourCellsLabel.
  ///
  /// In en, this message translates to:
  /// **'the 4 cells near row {row}, column {col}'**
  String vsGuideFourCellsLabel(int row, int col);

  /// No description provided for @vsGuideIntro.
  ///
  /// In en, this message translates to:
  /// **'In VS Mode, you take turns applying gates and try to finish with more pieces.'**
  String get vsGuideIntro;

  /// No description provided for @vsGuideSelectX.
  ///
  /// In en, this message translates to:
  /// **'First, choose the X gate'**
  String get vsGuideSelectX;

  /// No description provided for @vsGuideSelectBoard.
  ///
  /// In en, this message translates to:
  /// **'You\'ll gain the most pieces at {label}.\nTap the highlighted target'**
  String vsGuideSelectBoard(String label);

  /// No description provided for @vsGuideApply.
  ///
  /// In en, this message translates to:
  /// **'Tap Apply Gate'**
  String get vsGuideApply;

  /// No description provided for @vsGuideForbidden.
  ///
  /// In en, this message translates to:
  /// **'Your opponent can\'t use the area you just played.\nIt stays forbidden on their turn.'**
  String get vsGuideForbidden;

  /// No description provided for @vsGuideCooldown.
  ///
  /// In en, this message translates to:
  /// **'Your turn.\nThe X gate you just used is on cooldown.'**
  String get vsGuideCooldown;

  /// No description provided for @vsGuideGateStrength.
  ///
  /// In en, this message translates to:
  /// **'A quick guide to gate strength.\nGates that flip more of your opponent\'s pieces to your colour are stronger.\nX / Y > H > CNOT > Z > SWAP'**
  String get vsGuideGateStrength;

  /// No description provided for @vsGuideInfo.
  ///
  /// In en, this message translates to:
  /// **'You can check each gate\'s effect anytime with this info button.'**
  String get vsGuideInfo;

  /// No description provided for @vsGuideMeasure.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached 20 turns.\nTap Run Measurement to decide the winner.'**
  String get vsGuideMeasure;

  /// No description provided for @vsQuitTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave this match?'**
  String get vsQuitTitle;

  /// No description provided for @vsQuitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your board will be saved.'**
  String get vsQuitMessage;

  /// No description provided for @undoMove.
  ///
  /// In en, this message translates to:
  /// **'Undo move'**
  String get undoMove;

  /// No description provided for @makeBoardAllWhite.
  ///
  /// In en, this message translates to:
  /// **'Turn the whole board white'**
  String get makeBoardAllWhite;

  /// No description provided for @makeBoardAllBlack.
  ///
  /// In en, this message translates to:
  /// **'Turn the whole board black'**
  String get makeBoardAllBlack;

  /// No description provided for @runMeasurement.
  ///
  /// In en, this message translates to:
  /// **'Run Measurement'**
  String get runMeasurement;

  /// No description provided for @measureConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to measure?'**
  String get measureConfirmTitle;

  /// No description provided for @measureConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Measure now and show the result?'**
  String get measureConfirmMessage;

  /// No description provided for @resultDraw.
  ///
  /// In en, this message translates to:
  /// **'DRAW'**
  String get resultDraw;

  /// No description provided for @resultVictory.
  ///
  /// In en, this message translates to:
  /// **'VICTORY'**
  String get resultVictory;

  /// No description provided for @resultDefeat.
  ///
  /// In en, this message translates to:
  /// **'DEFEAT'**
  String get resultDefeat;

  /// No description provided for @resultWhiteWins.
  ///
  /// In en, this message translates to:
  /// **'WHITE WINS'**
  String get resultWhiteWins;

  /// No description provided for @resultBlackWins.
  ///
  /// In en, this message translates to:
  /// **'BLACK WINS'**
  String get resultBlackWins;

  /// No description provided for @resultBannerVictory.
  ///
  /// In en, this message translates to:
  /// **'VICTORY'**
  String get resultBannerVictory;

  /// No description provided for @resultBannerDefeat.
  ///
  /// In en, this message translates to:
  /// **'DEFEAT'**
  String get resultBannerDefeat;

  /// No description provided for @resultBannerDraw.
  ///
  /// In en, this message translates to:
  /// **'DRAW'**
  String get resultBannerDraw;

  /// No description provided for @resultBannerWinner.
  ///
  /// In en, this message translates to:
  /// **'WINNER'**
  String get resultBannerWinner;

  /// No description provided for @matchResultBarrierLabel.
  ///
  /// In en, this message translates to:
  /// **'Match result'**
  String get matchResultBarrierLabel;

  /// No description provided for @resultYouWhite.
  ///
  /// In en, this message translates to:
  /// **'You (White)'**
  String get resultYouWhite;

  /// No description provided for @resultCpuBlack.
  ///
  /// In en, this message translates to:
  /// **'CPU (Black)'**
  String get resultCpuBlack;

  /// No description provided for @resultViewResult.
  ///
  /// In en, this message translates to:
  /// **'View result'**
  String get resultViewResult;

  /// No description provided for @resultGoToRanking.
  ///
  /// In en, this message translates to:
  /// **'View ranking'**
  String get resultGoToRanking;

  /// No description provided for @timeAttackModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Attack Mode'**
  String get timeAttackModeTitle;

  /// No description provided for @timeAttackTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Attack'**
  String get timeAttackTitle;

  /// No description provided for @timeAttackHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Attack\nChallenge'**
  String get timeAttackHeroTitle;

  /// No description provided for @timeAttackIntro.
  ///
  /// In en, this message translates to:
  /// **'You start with 30 seconds.\nClearing puzzles adds more TIME.'**
  String get timeAttackIntro;

  /// No description provided for @timeAttackComboHint.
  ///
  /// In en, this message translates to:
  /// **'String PERFECTs together for a COMBO BONUS!'**
  String get timeAttackComboHint;

  /// No description provided for @timeAttackNetworkRequired.
  ///
  /// In en, this message translates to:
  /// **'An internet connection is required for Time Attack.'**
  String get timeAttackNetworkRequired;

  /// No description provided for @timeAttackStart.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get timeAttackStart;

  /// No description provided for @timeAttackRanking.
  ///
  /// In en, this message translates to:
  /// **'RANKING'**
  String get timeAttackRanking;

  /// No description provided for @timeAttackDebugPreview.
  ///
  /// In en, this message translates to:
  /// **'DEBUG PREVIEW'**
  String get timeAttackDebugPreview;

  /// No description provided for @timeAttackDebugViewClear.
  ///
  /// In en, this message translates to:
  /// **'View CLEAR screen'**
  String get timeAttackDebugViewClear;

  /// No description provided for @timeAttackDebugViewAllClear.
  ///
  /// In en, this message translates to:
  /// **'View ALL CLEAR screen'**
  String get timeAttackDebugViewAllClear;

  /// No description provided for @timeAttackHudTime.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get timeAttackHudTime;

  /// No description provided for @timeAttackHudClear.
  ///
  /// In en, this message translates to:
  /// **'CLEAR'**
  String get timeAttackHudClear;

  /// No description provided for @timeAttackHudBestTurns.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get timeAttackHudBestTurns;

  /// No description provided for @timeAttackHudTurns.
  ///
  /// In en, this message translates to:
  /// **'Turns'**
  String get timeAttackHudTurns;

  /// No description provided for @timeAttackHudCombo.
  ///
  /// In en, this message translates to:
  /// **'COMBO'**
  String get timeAttackHudCombo;

  /// No description provided for @timeAttackAllClear.
  ///
  /// In en, this message translates to:
  /// **'ALL CLEAR!'**
  String get timeAttackAllClear;

  /// No description provided for @timeAttackPerfect.
  ///
  /// In en, this message translates to:
  /// **'PERFECT!'**
  String get timeAttackPerfect;

  /// No description provided for @timeAttackClear.
  ///
  /// In en, this message translates to:
  /// **'CLEAR!'**
  String get timeAttackClear;

  /// No description provided for @timeAttackComboCount.
  ///
  /// In en, this message translates to:
  /// **'{n} COMBO'**
  String timeAttackComboCount(int n);

  /// No description provided for @timeAttackBonusGained.
  ///
  /// In en, this message translates to:
  /// **'+{n} BONUS'**
  String timeAttackBonusGained(int n);

  /// {sec} is the bonus in seconds as a pre-formatted string, e.g. 3.5
  ///
  /// In en, this message translates to:
  /// **'TIME +{sec}'**
  String timeAttackTimeBonus(String sec);

  /// No description provided for @timeAttackNextLabel.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get timeAttackNextLabel;

  /// No description provided for @timeAttackQuitTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit?'**
  String get timeAttackQuitTitle;

  /// No description provided for @timeAttackQuitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your current Time Attack run will be discarded.'**
  String get timeAttackQuitMessage;

  /// No description provided for @timeAttackNewRecord.
  ///
  /// In en, this message translates to:
  /// **'NEW RECORD!'**
  String get timeAttackNewRecord;

  /// No description provided for @timeAttackTotalScore.
  ///
  /// In en, this message translates to:
  /// **'TOTAL SCORE'**
  String get timeAttackTotalScore;

  /// No description provided for @timeAttackClearBonus.
  ///
  /// In en, this message translates to:
  /// **'CLEAR BONUS'**
  String get timeAttackClearBonus;

  /// No description provided for @timeAttackBonusHeading.
  ///
  /// In en, this message translates to:
  /// **'BONUS'**
  String get timeAttackBonusHeading;

  /// No description provided for @timeAttackMaxCombo.
  ///
  /// In en, this message translates to:
  /// **'MAX COMBO'**
  String get timeAttackMaxCombo;

  /// No description provided for @timeAttackComboBonus.
  ///
  /// In en, this message translates to:
  /// **'COMBO BONUS'**
  String get timeAttackComboBonus;

  /// No description provided for @timeAttackTimeBonusLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME BONUS'**
  String get timeAttackTimeBonusLabel;

  /// No description provided for @timeAttackSubmitFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t submit your score'**
  String get timeAttackSubmitFailed;

  /// No description provided for @timeAttackNothingToResubmit.
  ///
  /// In en, this message translates to:
  /// **'Nothing left to resubmit'**
  String get timeAttackNothingToResubmit;

  /// No description provided for @timeAttackResubmit.
  ///
  /// In en, this message translates to:
  /// **'Resubmit'**
  String get timeAttackResubmit;

  /// No description provided for @timeAttackSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting…'**
  String get timeAttackSubmitting;

  /// No description provided for @timeAttackViewRanking.
  ///
  /// In en, this message translates to:
  /// **'View Ranking'**
  String get timeAttackViewRanking;

  /// No description provided for @timeAttackRankingInfoUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load ranking info'**
  String get timeAttackRankingInfoUnavailable;

  /// No description provided for @timeAttackRankCalcFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t place this score on the ranking'**
  String get timeAttackRankCalcFailed;

  /// No description provided for @rankingTitle.
  ///
  /// In en, this message translates to:
  /// **'Ranking'**
  String get rankingTitle;

  /// No description provided for @rankingLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the ranking'**
  String get rankingLoadFailed;

  /// No description provided for @rankingYou.
  ///
  /// In en, this message translates to:
  /// **'YOU'**
  String get rankingYou;

  /// No description provided for @rankingNoRecordYet.
  ///
  /// In en, this message translates to:
  /// **'No record yet'**
  String get rankingNoRecordYet;

  /// No description provided for @rankingNicknameColumn.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get rankingNicknameColumn;

  /// No description provided for @rankingWinsColumn.
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get rankingWinsColumn;

  /// No description provided for @rankingTotalScoreLine.
  ///
  /// In en, this message translates to:
  /// **'TOTAL SCORE  {score}'**
  String rankingTotalScoreLine(int score);

  /// No description provided for @rankingClearCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Clears'**
  String get rankingClearCountLabel;

  /// No description provided for @rankingMaxCombo.
  ///
  /// In en, this message translates to:
  /// **'MAX COMBO'**
  String get rankingMaxCombo;

  /// No description provided for @rankingComboBonus.
  ///
  /// In en, this message translates to:
  /// **'COMBO BONUS'**
  String get rankingComboBonus;

  /// No description provided for @rankingTimeBonus.
  ///
  /// In en, this message translates to:
  /// **'TIME BONUS'**
  String get rankingTimeBonus;

  /// No description provided for @rankingUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get rankingUpdatedAt;

  /// No description provided for @nicknameChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Change name'**
  String get nicknameChangeTitle;

  /// No description provided for @nicknameHint.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nicknameHint;

  /// No description provided for @nicknameLengthError.
  ///
  /// In en, this message translates to:
  /// **'Enter {min}–{max} characters'**
  String nicknameLengthError(int min, int max);

  /// No description provided for @nicknameTaken.
  ///
  /// In en, this message translates to:
  /// **'That name is already taken'**
  String get nicknameTaken;

  /// No description provided for @nicknameBlocked.
  ///
  /// In en, this message translates to:
  /// **'That name includes a blocked word'**
  String get nicknameBlocked;

  /// No description provided for @nicknameSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save'**
  String get nicknameSaveFailed;

  /// No description provided for @playerNameTooltip.
  ///
  /// In en, this message translates to:
  /// **'Player name'**
  String get playerNameTooltip;

  /// No description provided for @settingsFreeOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick gates and pieces in any order'**
  String get settingsFreeOrderTitle;

  /// No description provided for @settingsFreeOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'When on, you can choose gates and pieces in any order.'**
  String get settingsFreeOrderDescription;

  /// No description provided for @settingsGateEffectIconTitle.
  ///
  /// In en, this message translates to:
  /// **'Show effects on gate buttons'**
  String get settingsGateEffectIconTitle;

  /// No description provided for @settingsGateEffectIconDescription.
  ///
  /// In en, this message translates to:
  /// **'When on, each button shows how pieces change. When off, buttons show text only.'**
  String get settingsGateEffectIconDescription;

  /// No description provided for @settingsDoubleTapTitle.
  ///
  /// In en, this message translates to:
  /// **'Double-tap to apply instantly'**
  String get settingsDoubleTapTitle;

  /// No description provided for @settingsDoubleTapDescription.
  ///
  /// In en, this message translates to:
  /// **'After choosing a gate, quickly tap the same piece twice to apply it right away. Tap the same row or column button again to apply it there without clearing your selection.'**
  String get settingsDoubleTapDescription;

  /// No description provided for @settingsVolumeHeading.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get settingsVolumeHeading;

  /// No description provided for @settingsVolumeBgm.
  ///
  /// In en, this message translates to:
  /// **'BGM'**
  String get settingsVolumeBgm;

  /// No description provided for @settingsVolumeSfx.
  ///
  /// In en, this message translates to:
  /// **'Sound effects'**
  String get settingsVolumeSfx;

  /// No description provided for @legalPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get legalPrivacyPolicy;

  /// No description provided for @legalSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get legalSupport;

  /// URL opened by the Privacy Policy item (not user-visible text)
  ///
  /// In en, this message translates to:
  /// **'https://q-tech-gaming.github.io/q-reversi-privacy-policy/en/'**
  String get legalPrivacyPolicyUrl;

  /// URL opened by the Support item (not user-visible text)
  ///
  /// In en, this message translates to:
  /// **'https://q-tech-gaming.github.io/support/en/'**
  String get legalSupportUrl;

  /// No description provided for @legalDeleteRankingData.
  ///
  /// In en, this message translates to:
  /// **'Delete ranking data'**
  String get legalDeleteRankingData;

  /// No description provided for @legalDeleteRankingDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name, scores, wins, and more'**
  String get legalDeleteRankingDataSubtitle;

  /// No description provided for @legalCouldNotOpenPage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the page'**
  String get legalCouldNotOpenPage;

  /// No description provided for @legalDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete ranking data'**
  String get legalDeleteDialogTitle;

  /// No description provided for @legalDeleteDialogBody.
  ///
  /// In en, this message translates to:
  /// **'This deletes ranking data from the server and this device — including Time Attack records, VS Quantum AI wins, and your player name.\n\nChallenge progress and control settings stay. This can\'t be undone.'**
  String get legalDeleteDialogBody;

  /// No description provided for @legalDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete for real?'**
  String get legalDeleteConfirmTitle;

  /// No description provided for @legalDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Cloud data and related data on this device will both be deleted.'**
  String get legalDeleteConfirmBody;

  /// No description provided for @legalDeleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting…'**
  String get legalDeleting;

  /// No description provided for @legalDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete ranking data'**
  String get legalDeleteFailed;

  /// No description provided for @legalDeleteDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get legalDeleteDoneTitle;

  /// No description provided for @legalDeleteFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t delete'**
  String get legalDeleteFailedTitle;

  /// No description provided for @legalDeleteDoneMessage.
  ///
  /// In en, this message translates to:
  /// **'Your ranking data has been deleted.'**
  String get legalDeleteDoneMessage;

  /// No description provided for @tutorialTitle.
  ///
  /// In en, this message translates to:
  /// **'Tutorial'**
  String get tutorialTitle;

  /// No description provided for @tutorialComplete.
  ///
  /// In en, this message translates to:
  /// **'Tutorial complete!'**
  String get tutorialComplete;

  /// No description provided for @tutorialReturnToModeSelect.
  ///
  /// In en, this message translates to:
  /// **'Heading back to mode select.'**
  String get tutorialReturnToModeSelect;

  /// No description provided for @tutorialStartOperating.
  ///
  /// In en, this message translates to:
  /// **'Try it'**
  String get tutorialStartOperating;

  /// No description provided for @tutorialSelectGateButton.
  ///
  /// In en, this message translates to:
  /// **'Choose a gate button.'**
  String get tutorialSelectGateButton;

  /// No description provided for @tutorialIntroConcept.
  ///
  /// In en, this message translates to:
  /// **'Q-Reversi Tutorial'**
  String get tutorialIntroConcept;

  /// No description provided for @tutorialIntroHowTo.
  ///
  /// In en, this message translates to:
  /// **'Tap the highlighted spot.'**
  String get tutorialIntroHowTo;

  /// No description provided for @tutorialClear.
  ///
  /// In en, this message translates to:
  /// **'Clear!'**
  String get tutorialClear;

  /// No description provided for @tutorialGateChangesPieces.
  ///
  /// In en, this message translates to:
  /// **'Applying a gate button below changes the pieces.'**
  String get tutorialGateChangesPieces;

  /// No description provided for @tutorialGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal: {goal}'**
  String tutorialGoalLabel(String goal);

  /// No description provided for @tutorialStatusSelectFirstCell.
  ///
  /// In en, this message translates to:
  /// **'Choose the first cell'**
  String get tutorialStatusSelectFirstCell;

  /// No description provided for @tutorialStatusSelectSecondCell.
  ///
  /// In en, this message translates to:
  /// **'Choose the second cell'**
  String get tutorialStatusSelectSecondCell;

  /// No description provided for @tutorialStatusTwoCellsSelected.
  ///
  /// In en, this message translates to:
  /// **'2 cells selected'**
  String get tutorialStatusTwoCellsSelected;

  /// No description provided for @tutorialStatusSelectRowColumnOrCell.
  ///
  /// In en, this message translates to:
  /// **'Choose a row/column button or a cell'**
  String get tutorialStatusSelectRowColumnOrCell;

  /// No description provided for @tutorialTopicControls.
  ///
  /// In en, this message translates to:
  /// **'Learn the controls'**
  String get tutorialTopicControls;

  /// No description provided for @tutorialTopicHGate.
  ///
  /// In en, this message translates to:
  /// **'Learn the H gate'**
  String get tutorialTopicHGate;

  /// No description provided for @tutorialTopicYGate.
  ///
  /// In en, this message translates to:
  /// **'Learn the Y gate'**
  String get tutorialTopicYGate;

  /// No description provided for @tutorialTopicZGate.
  ///
  /// In en, this message translates to:
  /// **'Learn the Z gate'**
  String get tutorialTopicZGate;

  /// No description provided for @tutorialTopicSwapGate.
  ///
  /// In en, this message translates to:
  /// **'Learn the SWAP gate'**
  String get tutorialTopicSwapGate;

  /// No description provided for @tutorialTopicCnotGate.
  ///
  /// In en, this message translates to:
  /// **'Learn the CNOT gate'**
  String get tutorialTopicCnotGate;

  /// No description provided for @tutorialHintSelectWholeRow.
  ///
  /// In en, this message translates to:
  /// **'You can also select a whole line at once.'**
  String get tutorialHintSelectWholeRow;

  /// No description provided for @tutorialClearNotePiecesChange.
  ///
  /// In en, this message translates to:
  /// **'Applying a gate changes the pieces.'**
  String get tutorialClearNotePiecesChange;

  /// No description provided for @tutorialClearNoteEffects.
  ///
  /// In en, this message translates to:
  /// **'Each gate has a different effect.'**
  String get tutorialClearNoteEffects;

  /// No description provided for @tutorialClearNoteTwoPieces.
  ///
  /// In en, this message translates to:
  /// **'Some gates choose two pieces.'**
  String get tutorialClearNoteTwoPieces;

  /// No description provided for @tutorialHintCnotBlackControl.
  ///
  /// In en, this message translates to:
  /// **'If the first piece is black, the second piece changes.'**
  String get tutorialHintCnotBlackControl;

  /// No description provided for @tutorialUnderstood.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get tutorialUnderstood;

  /// No description provided for @pieceGrayPlus.
  ///
  /// In en, this message translates to:
  /// **'Gray plus'**
  String get pieceGrayPlus;

  /// No description provided for @pieceGrayMinus.
  ///
  /// In en, this message translates to:
  /// **'Gray minus'**
  String get pieceGrayMinus;

  /// No description provided for @tutorialImageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Image not found'**
  String get tutorialImageNotFound;

  /// No description provided for @tutorialImageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load image\n{path}\n\nError: {error}'**
  String tutorialImageLoadError(String path, String error);

  /// No description provided for @tutorialVideoPathMissing.
  ///
  /// In en, this message translates to:
  /// **'No video path specified'**
  String get tutorialVideoPathMissing;

  /// No description provided for @tutorialVideoLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load video\n{path}\n\nError: {error}'**
  String tutorialVideoLoadError(String path, String error);

  /// No description provided for @tutorialDiagramLabel.
  ///
  /// In en, this message translates to:
  /// **'Diagram'**
  String get tutorialDiagramLabel;

  /// No description provided for @tutorialAnimationLabel.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get tutorialAnimationLabel;

  /// No description provided for @tutorialEntangledState.
  ///
  /// In en, this message translates to:
  /// **'Entangled'**
  String get tutorialEntangledState;

  /// No description provided for @tutorialCnotPatternNormal.
  ///
  /// In en, this message translates to:
  /// **'Standard pattern'**
  String get tutorialCnotPatternNormal;

  /// No description provided for @tutorialCnotPatternVsWhite.
  ///
  /// In en, this message translates to:
  /// **'VS Mode · White player'**
  String get tutorialCnotPatternVsWhite;

  /// No description provided for @tutorialPatternListPending.
  ///
  /// In en, this message translates to:
  /// **'Pattern list (coming soon)'**
  String get tutorialPatternListPending;

  /// No description provided for @tutorialEntanglementResultWhite.
  ///
  /// In en, this message translates to:
  /// **'Measured: White + White (entangled)'**
  String get tutorialEntanglementResultWhite;

  /// No description provided for @tutorialEntanglementResultBlack.
  ///
  /// In en, this message translates to:
  /// **'Measured: Black + Black (entangled)'**
  String get tutorialEntanglementResultBlack;

  /// No description provided for @tutorialCnotGrayControlNote.
  ///
  /// In en, this message translates to:
  /// **'Gray control bit: 50/50 white or black'**
  String get tutorialCnotGrayControlNote;

  /// No description provided for @tutorialClassicalComputer.
  ///
  /// In en, this message translates to:
  /// **'Classical computer'**
  String get tutorialClassicalComputer;

  /// No description provided for @tutorialQuantumComputer.
  ///
  /// In en, this message translates to:
  /// **'Quantum computer'**
  String get tutorialQuantumComputer;

  /// No description provided for @tutorialQReversi.
  ///
  /// In en, this message translates to:
  /// **'Q-Reversi'**
  String get tutorialQReversi;

  /// No description provided for @tutorialDemoSelectGate.
  ///
  /// In en, this message translates to:
  /// **'Choose a gate'**
  String get tutorialDemoSelectGate;

  /// No description provided for @tutorialDemoSelectColumn.
  ///
  /// In en, this message translates to:
  /// **'Choose a column'**
  String get tutorialDemoSelectColumn;

  /// No description provided for @tutorialDemoSelectRow.
  ///
  /// In en, this message translates to:
  /// **'Choose a row'**
  String get tutorialDemoSelectRow;

  /// No description provided for @tutorialDemoSelectFourCells.
  ///
  /// In en, this message translates to:
  /// **'Choose 4 cells'**
  String get tutorialDemoSelectFourCells;

  /// No description provided for @studyMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Study Mode'**
  String get studyMenuTitle;

  /// No description provided for @studyMenuIntro.
  ///
  /// In en, this message translates to:
  /// **'What is a quantum computer?'**
  String get studyMenuIntro;

  /// No description provided for @studyMenuOneCell.
  ///
  /// In en, this message translates to:
  /// **'Quantum Computing\nin 1 Cell'**
  String get studyMenuOneCell;

  /// No description provided for @studyMenuTwoCell.
  ///
  /// In en, this message translates to:
  /// **'Quantum Computing\nin 2 Cells'**
  String get studyMenuTwoCell;

  /// No description provided for @studyMenuThreeCell.
  ///
  /// In en, this message translates to:
  /// **'Grover\'s Algorithm\nin 3 Cells'**
  String get studyMenuThreeCell;

  /// No description provided for @studyMenuEpilogue.
  ///
  /// In en, this message translates to:
  /// **'Epilogue'**
  String get studyMenuEpilogue;

  /// No description provided for @studyNavigationFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open that screen'**
  String get studyNavigationFailed;

  /// No description provided for @studyOneCellTitle.
  ///
  /// In en, this message translates to:
  /// **'1 Cell'**
  String get studyOneCellTitle;

  /// No description provided for @studyTwoCellTitle.
  ///
  /// In en, this message translates to:
  /// **'2 Cells'**
  String get studyTwoCellTitle;

  /// No description provided for @studyThreeCellTitle.
  ///
  /// In en, this message translates to:
  /// **'3 Cells'**
  String get studyThreeCellTitle;

  /// No description provided for @studyTabBlochSphere.
  ///
  /// In en, this message translates to:
  /// **'Bloch Sphere'**
  String get studyTabBlochSphere;

  /// No description provided for @studyTabAmplitude.
  ///
  /// In en, this message translates to:
  /// **'Probability Amplitude'**
  String get studyTabAmplitude;

  /// No description provided for @studyTextButton.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get studyTextButton;

  /// No description provided for @studyCurrentState.
  ///
  /// In en, this message translates to:
  /// **'Current state: {state}'**
  String studyCurrentState(String state);

  /// No description provided for @studyStateWhite.
  ///
  /// In en, this message translates to:
  /// **'White piece |0⟩'**
  String get studyStateWhite;

  /// No description provided for @studyStateBlack.
  ///
  /// In en, this message translates to:
  /// **'Black piece |1⟩'**
  String get studyStateBlack;

  /// No description provided for @studyStateGrayPlus.
  ///
  /// In en, this message translates to:
  /// **'Gray plus |+⟩'**
  String get studyStateGrayPlus;

  /// No description provided for @studyStateGrayMinus.
  ///
  /// In en, this message translates to:
  /// **'Gray minus |-⟩'**
  String get studyStateGrayMinus;

  /// No description provided for @studyStateUnsupported.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get studyStateUnsupported;

  /// No description provided for @studyAmplitudeChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Probability amplitude (-1 to 1)'**
  String get studyAmplitudeChartTitle;

  /// No description provided for @studyProbabilityChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Probability (0 to 1)'**
  String get studyProbabilityChartTitle;

  /// No description provided for @studyApplying.
  ///
  /// In en, this message translates to:
  /// **'Applying…'**
  String get studyApplying;

  /// No description provided for @studyTwoCellHintSelectGate.
  ///
  /// In en, this message translates to:
  /// **'Choose a gate, then pick where to apply it'**
  String get studyTwoCellHintSelectGate;

  /// No description provided for @studyTwoCellHintTwoBit.
  ///
  /// In en, this message translates to:
  /// **'Tap two adjacent cells in order (control first, then target)'**
  String get studyTwoCellHintTwoBit;

  /// No description provided for @studyTwoCellHintOneBit.
  ///
  /// In en, this message translates to:
  /// **'Tap a cell, or a side row button to select the whole row'**
  String get studyTwoCellHintOneBit;

  /// No description provided for @studyGroverWrongStep.
  ///
  /// In en, this message translates to:
  /// **'Wrong step. Tap Reset to start over.'**
  String get studyGroverWrongStep;

  /// No description provided for @studyGroverStepBroken.
  ///
  /// In en, this message translates to:
  /// **'That broke the sequence. Tap Reset to start over.'**
  String get studyGroverStepBroken;

  /// No description provided for @studyGroverCircuitConsumed.
  ///
  /// In en, this message translates to:
  /// **'All circuit steps are used. Measure to lock in the state.'**
  String get studyGroverCircuitConsumed;

  /// No description provided for @studyGroverCircuitDone.
  ///
  /// In en, this message translates to:
  /// **'Circuit complete. Tap Measure to lock in the state.'**
  String get studyGroverCircuitDone;

  /// No description provided for @studyGroverChooseGate.
  ///
  /// In en, this message translates to:
  /// **'Choose H, CCZ, or Diff.'**
  String get studyGroverChooseGate;

  /// No description provided for @studyGroverPressApply.
  ///
  /// In en, this message translates to:
  /// **'Tap Apply Gate.'**
  String get studyGroverPressApply;

  /// No description provided for @studyGroverMeasureResult.
  ///
  /// In en, this message translates to:
  /// **'Measured: {result}'**
  String studyGroverMeasureResult(String result);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
