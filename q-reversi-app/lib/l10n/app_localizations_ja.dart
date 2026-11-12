// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Qリバーシ';

  @override
  String appVersionLabel(String version) {
    return 'v$version';
  }

  @override
  String get cancel => 'キャンセル';

  @override
  String get close => '閉じる';

  @override
  String get save => '保存';

  @override
  String get retry => '再試行';

  @override
  String get tryAgain => 'リトライ';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get ok => 'OK';

  @override
  String get next => '次へ';

  @override
  String get previous => '前へ';

  @override
  String get done => '完了';

  @override
  String get exit => '終了';

  @override
  String get back => '戻る';

  @override
  String get continueAction => '続ける';

  @override
  String get deleteAction => '削除する';

  @override
  String get settings => '設定';

  @override
  String get skip => 'スキップ';

  @override
  String get understood => '理解しました';

  @override
  String get startOver => '最初から';

  @override
  String get later => 'あとで';

  @override
  String get loading => '読み込み中…';

  @override
  String get refresh => '更新';

  @override
  String get errorOccurred => 'エラーが発生しました';

  @override
  String get helpAndInfo => 'ヘルプ・情報';

  @override
  String pageCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get pieceWhite => '白';

  @override
  String get pieceBlack => '黒';

  @override
  String get whiteScoreLabel => '白: ';

  @override
  String get blackScoreLabel => '黒: ';

  @override
  String get playerLabelPrefix => 'プレイヤー: ';

  @override
  String playerLabel(String label) {
    return 'プレイヤー: $label';
  }

  @override
  String turnCounterOfMax(int turn, int maxTurns) {
    return 'ターン: $turn/$maxTurns';
  }

  @override
  String turnsCount(int n) {
    return 'ターン: $n';
  }

  @override
  String goalLabel(String goal) {
    return 'ゴール: $goal';
  }

  @override
  String optimalTurnsLabel(int n) {
    return '最短ターン: $n';
  }

  @override
  String levelTitle(String label) {
    return 'レベル $label';
  }

  @override
  String stageLabel(int n) {
    return 'ステージ $n';
  }

  @override
  String get cpuThinking => 'CPU思考中...';

  @override
  String get victoryAllWhite => 'すべて白にする';

  @override
  String get victoryAllBlack => 'すべて黒にする';

  @override
  String get difficultyBeginner => '初級';

  @override
  String get difficultyIntermediate => '中級';

  @override
  String get difficultyAdvanced => '上級';

  @override
  String get difficultyQuantumAi => '量子AI';

  @override
  String get homeStart => 'START';

  @override
  String get modeTutorialTitle => 'チュートリアル';

  @override
  String get modeTutorialSubtitle => 'ゲームの遊び方説明';

  @override
  String get modeChallengeTitle => 'チャレンジモード';

  @override
  String get modeChallengeSubtitle => '特定の量子状態を作るパズルゲーム';

  @override
  String get modeTimeAttackTitle => 'タイムアタックモード';

  @override
  String get modeTimeAttackSubtitle => 'タイムアタックでランキング';

  @override
  String get modeVsTitle => 'VSモード';

  @override
  String get modeVsSubtitle => '2人対戦のモード';

  @override
  String get modeFreeRunTitle => 'フリーランモード';

  @override
  String get modeFreeRunSubtitle => '自由にゲートを演算できるモード';

  @override
  String get modeStudyTitle => 'スタディモード';

  @override
  String get modeStudySubtitle => '量子コンピュータを感覚的に学習';

  @override
  String get modeUnlockByChallengeStage0 =>
      'チャレンジモードのステージ0をクリアすると、このモードが解放されます';

  @override
  String get modeRequiresTutorial => 'チュートリアルを完了またはスキップしてから、このモードをプレイできます';

  @override
  String get resumeBattleTitle => '続きから対戦';

  @override
  String get resumeBattleMessage => '前回の続きから対戦を開始しますか？';

  @override
  String get vsSetupTitle => 'VSモード設定';

  @override
  String get vsCpuDifficultyHeading => 'CPU難易度';

  @override
  String get vsDifficultyUnlockNote => '各難易度に勝利すると次の難易度が解放されます。';

  @override
  String get vsDifficultyColumn => '難易度';

  @override
  String get vsRecordColumn => '成績';

  @override
  String get vsLegendLoss => '負';

  @override
  String get vsLegendDraw => '引';

  @override
  String get vsLegendWin => '勝';

  @override
  String vsRecordSummary(int wins, int played) {
    return '$wins勝 / $played戦';
  }

  @override
  String get vsQuantumAiDescription => '量子コンピュータで機械学習したAI';

  @override
  String get vsBattleModeHeading => '対戦モード';

  @override
  String get vsModeVsCpu => '対CPU戦';

  @override
  String get vsModeVsHuman => '対人戦';

  @override
  String get vsVsHumanLocked => '対CPU戦を1回プレイすると解放されます';

  @override
  String get vsTurnsHeading => 'ターン数';

  @override
  String get vsTurnsLockedNote => '最初は20ターン固定です。対CPU戦を1回プレイすると変更できます。';

  @override
  String vsTurnsOption(int turns) {
    return '$turnsターン';
  }

  @override
  String get vsStartGame => 'ゲーム開始';

  @override
  String get vsQuantumAiRanking => 'VS量子AI RANKING';

  @override
  String get challengeModeTitle => 'チャレンジモード';

  @override
  String get challengeNoLevels => 'レベルが見つかりません';

  @override
  String challengeStageProgress(int done, int total) {
    return '$done / $total クリア';
  }

  @override
  String challengeStageProgressUnlock(int done, int total) {
    return '$done / $total クリア\n全クリアで他モード開放';
  }

  @override
  String get challengeGuideStep1 =>
      '1. クリア条件を確認してください。\n盤面をすべて白にするか、黒にしたらレベルクリアです';

  @override
  String get challengeGuideStep2 => '2. ゲートを選択してください';

  @override
  String get challengeGuideStep3 =>
      '3. 適用する駒を選択してください。\n盤面の中をタップか、盤面の外のボタンをタップしてください';

  @override
  String get challengeGuideStep4 => '4. \"ゲートを適用\"ボタンでゲートを駒に適用させて下さい';

  @override
  String get challengeGuideStep5 => '5. いつでもこのinfoボタンから、ゲートの効果を確認できます';

  @override
  String get challengeAvailableGates => '使用可能ゲート';

  @override
  String get challengeLevelClearTitle => '🎉 レベルクリア！';

  @override
  String challengeLevelClearMessage(String label) {
    return 'レベル $label をクリアしました！';
  }

  @override
  String challengeTurnsUsed(int n) {
    return '使用ターン数: $n';
  }

  @override
  String get applyGate => 'ゲートを適用';

  @override
  String get reset => 'リセット';

  @override
  String get measure => '測定';

  @override
  String get gateEffectsTitle => 'ゲート効果';

  @override
  String get gateEffectsTooltip => 'ゲート効果を見る';

  @override
  String get gateEffectPage1 => 'ゲート効果①';

  @override
  String get gateEffectPage2 => 'ゲート効果②';

  @override
  String get gateEffectNonCnot => 'ゲート効果(CNOT以外)';

  @override
  String get gateEffectCnotWhitePlayer => 'CNOT[プレイヤー白]';

  @override
  String get gateEffectCnotBlackPlayer => 'CNOT[プレイヤー黒]';

  @override
  String get hintSelectGateOrBoard => 'ゲートまたは盤面を選択してください';

  @override
  String get hintSelectGateFirst => '先にゲートを選択してください';

  @override
  String get hintSelectFirstCell => '1マス目を選択してください';

  @override
  String get hintSelectSecondCell => '2マス目を選択してください';

  @override
  String get hintTwoCellsSelected => '2マス選択済み';

  @override
  String get hintSelectRowColumnOrCell => '行/列ボタンまたはマスを選択してください';

  @override
  String get errorEntangledNotSelectable => 'エンタングル駒は選択できません';

  @override
  String get errorAdjacentOnly => '隣接した駒のみ選択できます';

  @override
  String get errorRegionContainsEntangled => 'エンタングル駒を含む領域は選択できません';

  @override
  String get errorRangeContainsEntangled => 'エンタングル駒を含む範囲は選択できません';

  @override
  String get errorGateApplyFailed => 'ゲートを適用できませんでした';

  @override
  String get errorGateApplyFailedForbidden =>
      'ゲートを適用できませんでした（禁止領域またはエンタングル状態のため）';

  @override
  String get errorForbiddenArea => 'この位置は禁止領域です。相手が前回使用した領域には置けません。';

  @override
  String get errorSelectXFirst => '最初はXを選択して下さい。';

  @override
  String errorSelectBestTarget(String label) {
    return '$label を選んでください（自分の駒が最も増える場所です）';
  }

  @override
  String errorSelectBestTargetThenApply(String label) {
    return '$label を選んでから適用してください';
  }

  @override
  String vsGuideRowLabel(int n) {
    return '$n行目';
  }

  @override
  String vsGuideColumnLabel(int n) {
    return '$n列目';
  }

  @override
  String vsGuideFourCellsLabel(int row, int col) {
    return '$row行$col列付近の4マス';
  }

  @override
  String get vsGuideIntro => 'VSモードでは、交互にゲートを適用し、自分の駒の多さで競います。';

  @override
  String get vsGuideSelectX => 'まずは X ゲートを選んでください';

  @override
  String vsGuideSelectBoard(String label, int netGain, int blackFlips) {
    return '自分の駒が最も増えるのは $label です（差し引き +$netGain：黒$blackFlips→白）。\n白枠の場所を選んでください';
  }

  @override
  String get vsGuideApply => '「ゲートを適用」を押してください';

  @override
  String get vsGuideForbidden =>
      '直前に適用した領域には、相手はゲートを適用できません。\n禁止領域として相手の手番に残ります';

  @override
  String get vsGuideCooldown => '自分のターンです。\nさっき使った X ゲートにはクールタイムが入っています';

  @override
  String get vsGuideGateStrength =>
      'ゲートの強さの目安です。\n相手の駒を多く自分の色に変えやすいほど強力です。\nX・Y ＞ H ＞ CNOT ＞ Z ＞ SWAP';

  @override
  String get vsGuideInfo => 'いつでもこの info ボタンから、各ゲートの効果を確認できます';

  @override
  String get vsGuideMeasure => '20ターンに到達しました。\n「測定操作を実行」を押して勝敗を確定しましょう';

  @override
  String get vsQuitTitle => '対戦を中断しますか？';

  @override
  String get vsQuitMessage => '盤面は保存されます。';

  @override
  String get undoMove => '手を戻す';

  @override
  String get makeBoardAllWhite => '盤面をすべて白にする';

  @override
  String get makeBoardAllBlack => '盤面をすべて黒にする';

  @override
  String get runMeasurement => '測定操作を実行';

  @override
  String get measureConfirmTitle => '測定の確認';

  @override
  String get measureConfirmMessage => '測定し、結果を表示しますか？';

  @override
  String get resultDraw => '引き分け';

  @override
  String get resultVictory => '勝利！';

  @override
  String get resultDefeat => '敗北';

  @override
  String get resultWhiteWins => '白の勝利！';

  @override
  String get resultBlackWins => '黒の勝利！';

  @override
  String get resultBannerVictory => 'VICTORY';

  @override
  String get resultBannerDefeat => 'DEFEAT';

  @override
  String get resultBannerDraw => 'DRAW';

  @override
  String get resultBannerWinner => 'WINNER';

  @override
  String get matchResultBarrierLabel => '対戦結果';

  @override
  String get resultYouWhite => 'あなた（白）';

  @override
  String get resultCpuBlack => 'CPU（黒）';

  @override
  String get resultViewResult => '結果を確認';

  @override
  String get resultGoToRanking => 'ランキングへ';

  @override
  String get timeAttackModeTitle => 'タイムアタックモード';

  @override
  String get timeAttackTitle => 'タイムアタック';

  @override
  String get timeAttackHeroTitle => 'タイムアタック\nチャレンジ';

  @override
  String get timeAttackIntro => '30秒からスタート。\n問題を解くとTIMEが追加されます。';

  @override
  String get timeAttackComboHint => 'PERFECTを連続するとCOMBO BONUS!';

  @override
  String get timeAttackNetworkRequired => 'TIME ATTACKの開始には通信が必要です。';

  @override
  String get timeAttackStart => 'START';

  @override
  String get timeAttackRanking => 'RANKING';

  @override
  String get timeAttackDebugPreview => 'DEBUG PREVIEW';

  @override
  String get timeAttackDebugViewClear => 'CLEAR 画面を見る';

  @override
  String get timeAttackDebugViewAllClear => 'ALL CLEAR 画面を見る';

  @override
  String get timeAttackHudTime => 'TIME';

  @override
  String get timeAttackHudClear => 'CLEAR';

  @override
  String get timeAttackHudBestTurns => '最短ターン';

  @override
  String get timeAttackHudTurns => 'ターン';

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
  String get timeAttackQuitTitle => '終了しますか？';

  @override
  String get timeAttackQuitMessage => '進行中のタイムアタックは破棄されます。';

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
  String get timeAttackSubmitFailed => 'ランキング送信に失敗しました';

  @override
  String get timeAttackNothingToResubmit => '再送信できるデータがありません';

  @override
  String get timeAttackResubmit => '再送信';

  @override
  String get timeAttackSubmitting => '送信中…';

  @override
  String get timeAttackViewRanking => 'ランキングを見る';

  @override
  String get timeAttackRankingInfoUnavailable => 'ランキング情報を取得できませんでした';

  @override
  String get timeAttackRankCalcFailed => '今回のスコアで順位を計算できませんでした';

  @override
  String get rankingTitle => 'ランキング';

  @override
  String get rankingLoadFailed => 'ランキングを読み込めませんでした';

  @override
  String get rankingYou => 'YOU';

  @override
  String get rankingNoRecordYet => 'あなたの記録はまだありません';

  @override
  String get rankingNicknameColumn => 'ニックネーム';

  @override
  String get rankingWinsColumn => '勝利数';

  @override
  String rankingTotalScoreLine(int score) {
    return 'TOTAL SCORE  $score';
  }

  @override
  String get rankingClearCountLabel => 'CLEAR数';

  @override
  String get rankingMaxCombo => 'MAX COMBO';

  @override
  String get rankingComboBonus => 'COMBO BONUS';

  @override
  String get rankingTimeBonus => 'TIME BONUS';

  @override
  String get rankingUpdatedAt => '更新日時';

  @override
  String get nicknameChangeTitle => 'プレイヤー名を変更';

  @override
  String get nicknameHint => 'ニックネーム';

  @override
  String nicknameLengthError(int min, int max) {
    return '$min〜$max文字で入力してください';
  }

  @override
  String get nicknameTaken => 'その名前はすでに使われています';

  @override
  String get nicknameBlocked => '使用できない言葉が含まれています';

  @override
  String get nicknameSaveFailed => '保存に失敗しました';

  @override
  String get playerNameTooltip => 'プレイヤー名';

  @override
  String get settingsFreeOrderTitle => 'ゲートと駒を好きな順で選ぶ';

  @override
  String get settingsFreeOrderDescription => 'オンにするとゲートと駒を順不同で選ぶことができます';

  @override
  String get settingsGateEffectIconTitle => 'ゲートボタンに効果を表示';

  @override
  String get settingsGateEffectIconDescription =>
      'オンにすると、ボタンの中に駒の変化が見えます。オフにすると文字だけのボタンに戻ります';

  @override
  String get settingsDoubleTapTitle => 'ダブルタップでゲートをすぐ適用';

  @override
  String get settingsDoubleTapDescription =>
      'ゲートを選んだあと、同じ駒をすばやく2回タップするとすぐ適用します。同じ行・列ボタンをもう一度押すと、選択を外さずにその範囲へ適用します';

  @override
  String get settingsVolumeHeading => '音量';

  @override
  String get settingsVolumeBgm => 'BGM';

  @override
  String get settingsVolumeSfx => '効果音';

  @override
  String get legalPrivacyPolicy => 'プライバシーポリシー';

  @override
  String get legalSupport => 'サポート';

  @override
  String get legalPrivacyPolicyUrl =>
      'https://q-tech-gaming.github.io/q-reversi-privacy-policy/ja/';

  @override
  String get legalSupportUrl => 'https://q-tech-gaming.github.io/support/ja/';

  @override
  String get legalDeleteRankingData => 'ランキングデータの削除';

  @override
  String get legalDeleteRankingDataSubtitle => '表示名・スコア・勝利数など';

  @override
  String get legalCouldNotOpenPage => 'ページを開けませんでした';

  @override
  String get legalDeleteDialogTitle => 'ランキングデータを削除';

  @override
  String get legalDeleteDialogBody =>
      'タイムアタックの記録、VS量子AIの勝利数、プレイヤー名など、ランキングに関わるデータがサーバーとこの端末から削除されます。\n\nチャレンジの進行や操作設定は消えません。この操作は取り消せません。';

  @override
  String get legalDeleteConfirmTitle => '本当に削除しますか？';

  @override
  String get legalDeleteConfirmBody => 'クラウドデータとともに、この端末の関連データも削除されます。';

  @override
  String get legalDeleting => '削除しています…';

  @override
  String get legalDeleteFailed => 'ランキングデータの削除に失敗しました';

  @override
  String get legalDeleteDoneTitle => '削除しました';

  @override
  String get legalDeleteFailedTitle => '削除できませんでした';

  @override
  String get legalDeleteDoneMessage => 'ランキングに関わるデータは削除されました。';

  @override
  String get tutorialTitle => 'チュートリアル';

  @override
  String get tutorialComplete => 'チュートリアル完了';

  @override
  String get tutorialReturnToModeSelect => 'モード選択画面に戻ります。';

  @override
  String get tutorialStartOperating => '操作する';

  @override
  String get tutorialSelectGateButton => 'ゲートボタンを選んでください。';

  @override
  String get tutorialIntroConcept => 'このゲームは、量子コンピュータとリバーシをかけ合わせたゲームです。';

  @override
  String get tutorialIntroHowTo => 'まずは操作方法を学びましょう。\n光っているところをタップしてください。';

  @override
  String tutorialGoalLabel(String goal) {
    return 'ゴール: $goal';
  }

  @override
  String get tutorialStatusSelectFirstCell => '1マス目を選択してください';

  @override
  String get tutorialStatusSelectSecondCell => '2マス目を選択してください';

  @override
  String get tutorialStatusTwoCellsSelected => '2マス選択済み';

  @override
  String get tutorialStatusSelectRowColumnOrCell => '行/列ボタンまたはマスを選択してください';

  @override
  String get tutorialTopicControls => '操作方法を学ぶ';

  @override
  String get tutorialTopicHGate => 'Hゲートを学ぶ';

  @override
  String get tutorialTopicYGate => 'Yゲートを学ぶ';

  @override
  String get tutorialTopicZGate => 'Zゲートを学ぶ';

  @override
  String get tutorialTopicSwapGate => 'SWAPゲートを学ぶ';

  @override
  String get tutorialTopicCnotGate => 'CNOTゲートを学ぶ';

  @override
  String get tutorialHintSelectWholeRow => '1列まとめて選ぶこともできます。';

  @override
  String get tutorialHintCnotBlackControl => '1駒目に黒を選ぶと、2駒目が変化します。';

  @override
  String get tutorialUnderstood => '理解しました';

  @override
  String get pieceGrayPlus => 'グレープラス';

  @override
  String get pieceGrayMinus => 'グレーマイナス';

  @override
  String get tutorialImageNotFound => '画像が見つかりません';

  @override
  String tutorialImageLoadError(String path, String error) {
    return '画像を読み込めません\n$path\n\nエラー: $error';
  }

  @override
  String get tutorialVideoPathMissing => '動画パスが指定されていません';

  @override
  String tutorialVideoLoadError(String path, String error) {
    return '動画を読み込めません\n$path\n\nエラー: $error';
  }

  @override
  String get tutorialDiagramLabel => '図解';

  @override
  String get tutorialAnimationLabel => 'アニメーション';

  @override
  String get tutorialEntangledState => 'エンタングル状態';

  @override
  String get tutorialCnotPatternNormal => '通常パターン';

  @override
  String get tutorialCnotPatternVsWhite => 'VSモード白プレイヤー';

  @override
  String get tutorialPatternListPending => 'パターン一覧（詳細は実装中）';

  @override
  String get tutorialEntanglementResultWhite => '測定結果: 白 + 白（エンタングル）';

  @override
  String get tutorialEntanglementResultBlack => '測定結果: 黒 + 黒（エンタングル）';

  @override
  String get tutorialCnotGrayControlNote => 'グレー制御ビットが50%で白、50%で黒';

  @override
  String get tutorialClassicalComputer => '従来コンピュータ';

  @override
  String get tutorialQuantumComputer => '量子コンピュータ';

  @override
  String get tutorialQReversi => 'Qリバーシ';

  @override
  String get tutorialDemoSelectGate => 'ゲートを選択';

  @override
  String get tutorialDemoSelectColumn => '列を選択';

  @override
  String get tutorialDemoSelectRow => '行を選択';

  @override
  String get tutorialDemoSelectFourCells => '4マスを選択';

  @override
  String get studyMenuTitle => 'スタディモード';

  @override
  String get studyMenuIntro => '量子コンピュータとは？';

  @override
  String get studyMenuOneCell => '1マスで学ぶ\n量子コンピュータ';

  @override
  String get studyMenuTwoCell => '2マスで学ぶ\n量子コンピュータ';

  @override
  String get studyMenuThreeCell => '3マスで学ぶ\nグローバーのアルゴリズム';

  @override
  String get studyMenuEpilogue => '終わりに';

  @override
  String get studyNavigationFailed => '画面遷移に失敗しました';

  @override
  String get studyOneCellTitle => '1マスで学ぶ';

  @override
  String get studyTwoCellTitle => '2マスで学ぶ';

  @override
  String get studyThreeCellTitle => '3マスで学ぶ';

  @override
  String get studyTabBlochSphere => 'ブロッホ球';

  @override
  String get studyTabAmplitude => '確率振幅';

  @override
  String get studyTextButton => 'テキスト';

  @override
  String studyCurrentState(String state) {
    return '現在の状態: $state';
  }

  @override
  String get studyStateWhite => '白駒 |0⟩';

  @override
  String get studyStateBlack => '黒駒 |1⟩';

  @override
  String get studyStateGrayPlus => 'グレープラス |+⟩';

  @override
  String get studyStateGrayMinus => 'グレーマイナス |-⟩';

  @override
  String get studyStateUnsupported => '未対応';

  @override
  String get studyAmplitudeChartTitle => '確率振幅（-1 ～ 1）';

  @override
  String get studyProbabilityChartTitle => '存在確率（0 ～ 1）';

  @override
  String get studyApplying => '適用中...';

  @override
  String get studyTwoCellHintSelectGate => 'ゲートを選択し、盤面で適用先を選びます';

  @override
  String get studyTwoCellHintTwoBit => '隣接する2マスを順にタップ（1つ目が制御、2つ目がターゲット）';

  @override
  String get studyTwoCellHintOneBit => 'マスをタップ（1マス）または左右の行ボタン（1行まとめて）で対象を選びます';

  @override
  String get studyGroverWrongStep => '手順が違います。リセットで最初からやり直してください。';

  @override
  String get studyGroverStepBroken => '手順が崩れました。リセットで最初からやり直してください。';

  @override
  String get studyGroverCircuitConsumed => '回路をすべて消費しました。測定して状態を確定できます。';

  @override
  String get studyGroverCircuitDone => '回路の適用が完了しました。測定を押すと状態が確定します。';

  @override
  String get studyGroverChooseGate => 'H / CCZ / Diff のいずれかを選んでください。';

  @override
  String get studyGroverPressApply => '「ゲートを適用」を押してください。';

  @override
  String studyGroverMeasureResult(String result) {
    return '測定結果: $result';
  }
}
