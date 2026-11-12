import 'package:flutter/widgets.dart';

// Study モードの長文コンテンツ（ja / en）。
//
// 短い UI 文言は ARB（AppLocalizations）、長い解説文はこのモジュールに置く。
// StudyContent.of で Locale.languageCode が `ja` なら日本語、それ以外は英語を返す。

/// チュートリアルオーバーレイ 1 ステップ分のテキスト。
class StudyStepText {
  const StudyStepText({required this.title, required this.message});

  final String title;
  final String message;
}

class StudyContent {
  const StudyContent({
    required this.oneCellSteps,
    required this.twoCellSteps,
    required this.threeCellSteps,
    required this.epilogueLead,
    required this.epiloguePhaseTitle,
    required this.epiloguePhaseBullets,
    required this.epilogueLearnMoreTitle,
    required this.epilogueLearnMoreBody,
    required this.bulletMark,
  });

  /// 1マス: 6 ステップ。
  final List<StudyStepText> oneCellSteps;

  /// 2マス: 3 ステップ。
  final List<StudyStepText> twoCellSteps;

  /// 3マス: 14 ステップ。
  final List<StudyStepText> threeCellSteps;

  final String epilogueLead;
  final String epiloguePhaseTitle;
  final List<String> epiloguePhaseBullets;
  final String epilogueLearnMoreTitle;
  final String epilogueLearnMoreBody;
  final String bulletMark;

  static StudyContent of(Locale locale) =>
      locale.languageCode == 'ja' ? ja : en;

  static StudyContent ofContext(BuildContext context) =>
      of(Localizations.localeOf(context));

  // ---------------------------------------------------------------------------
  // 日本語
  // ---------------------------------------------------------------------------
  static const StudyContent ja = StudyContent(
    bulletMark: '・',
    oneCellSteps: [
      StudyStepText(
        title: '1マスで学ぶ量子コンピュータ',
        message:
            'このページでは、1量子ビットに対応する1マス盤面に対して、ブロッホ球と確率振幅グラフを用いて量子状態を直感的に学びます。',
      ),
      StudyStepText(
        title: 'ブロッホ球',
        message:
            'ブロッホ球とは、量子ビットの状態を球面上の点で表すモデルです。ここでは青の点で表しています。\nまた、ゲートの適用は、対応する軸まわりの回転として表現することができます。\nまずはゲートを1つ適用してみましょう。',
      ),
      StudyStepText(
        title: 'ゲート操作',
        message:
            'ゲートを適用すると、青の点がゲートの軸まわりに回転したかと思います。ブロッホ球は左右にスクロールして視点を変えることもできるので、ほかのゲートでも試してみてください。',
      ),
      StudyStepText(
        title: '確率振幅へ',
        message: '次は確率振幅を見てみましょう。準備ができたら「確率振幅」をタップしてください。',
      ),
      StudyStepText(
        title: '確率振幅',
        message:
            '量子ビットは0と1の中間状態を取り、その状態は複素数で表されます。確率振幅は、観測時に0または1として現れる重みを表す量です。\n※このゲームでは、グローバル位相（全成分に共通の位相）を除き、先頭の非ゼロ振幅が正の実数になるようにそろえたうえで、実数振幅（-1～1）として表示しています。',
      ),
      StudyStepText(
        title: '存在確率',
        message:
            '確率振幅は2乗すると存在確率（観測される確率）になります。\nゲートを操作して、それぞれの駒の確率振幅と存在確率の両方を見比べてみてください。',
      ),
    ],
    twoCellSteps: [
      StudyStepText(
        title: '2マスで学ぶ量子コンピュータ',
        message: 'このページでは、2量子ビットの状態を確率振幅と存在確率で体験します。',
      ),
      StudyStepText(
        title: '2量子ビットの表現',
        message:
            '1量子ビットのときは、|0⟩状態か|1⟩状態かの2択でした。2ビットになると、1番目が|0⟩と|1⟩、2番目が|0⟩と|1⟩でそれぞれ2通りずつあるため、掛け合わせて全部で4パターンの状態ができます。\n「|00⟩」のように | ⟩ の中に2つ数字が入る表記では、左が1ビット目、右が2ビット目を表します。',
      ),
      StudyStepText(
        title: '試してみよう',
        message:
            'この2マスの盤面を用いて、ゲートを適用して重ね合わせの状態を作ってみたり、エンタングルをしてみたりして2ビットの状態の変化を体験してみてください',
      ),
    ],
    threeCellSteps: [
      StudyStepText(
        title: '3マスで学ぶグローバーのアルゴリズム',
        message:
            'このページでは、量子コンピュータ特有のアルゴリズムの一つである"グローバーのアルゴリズム"を、3マス盤面と3つのゲートを用いて体験します。',
      ),
      StudyStepText(
        title: 'グローバーのアルゴリズムとは',
        message:
            'グローバーのアルゴリズムとは、たくさんの要素を持つデータベースの中から、指定された値を検索する「探索問題」を高速に解くための量子コンピュータのアルゴリズムで、大量のデータの中から、ある一つの値を検索したいときに効果を発揮します。',
      ),
      StudyStepText(
        title: '状態の数',
        message:
            '今回は3マス＝3量子ビットにこのアルゴリズムを適用してみます。3量子ビットになると、2の3乗で8個の組み合わせの量子状態ができます。',
      ),
      StudyStepText(
        title: '探し出す答え',
        message: '今回は、8個のパラメータの中から、|111⟩状態を探し出す、という問題を解くこととします。',
      ),
      StudyStepText(
        title: '新たなゲート(CCZ)',
        message:
            '|111⟩を探し出すにあたり、新たなゲートが必要になります。一つ目は、CCZ(Control-Control-Z)です。これは、CNOT(Control-X)と同じ考え方で、1ビット目と2ビット目が黒|1⟩の時にのみ、3ビット目にZを適用する操作になります。これによって、探したい|111⟩に印をつけることができます。',
      ),
      StudyStepText(
        title: '新たなゲート(Diff)',
        message:
            'もう一つは、Diff(Diffusion/反転)ゲートです。今回の3量子ビット・|111⟩探索では、Diffは H→X→CCZ→X→H の合成ゲートとして実装できます。\n[Diff = H→X→CCZ→X→H]\nこの操作により、各状態の確率振幅は「平均値に対して反転」し、印をつけた目標状態の振幅を増幅できます。',
      ),
      StudyStepText(
        title: '量子回路',
        message: 'さて、では早速このアルゴリズムを演算していきましょう。こちらの量子回路に従って、盤面にゲートを適用させてください。',
      ),
      StudyStepText(
        title: '重ね合わせの状態',
        message: '全体にHを適用することで、盤面の量子状態を重ね合わせの状態にします。',
      ),
      StudyStepText(
        title: '印をつける',
        message: 'CCZによって、量子回路から探したい数字に印(確率振幅の符号反転)をつけます。',
      ),
      StudyStepText(
        title: '反転する',
        message: 'Diffゲートによって、印をつけた数字の確率振幅を平均に対して反転させます',
      ),
      StudyStepText(
        title: 'アルゴリズム1回分適用完了',
        message:
            'グローバーのアルゴリズムを1回適用しました。この時点で、|111⟩の存在確率が78%まで上がっています。もう1周アルゴリズムを適用すると、取り出したい状態の存在確率が最大化します。続けて、アルゴリズムを適用しましょう。',
      ),
      StudyStepText(
        title: 'アルゴリズム2周完了',
        message:
            'グローバーのアルゴリズムを2回分適用することで、存在確率を95%まで上げることができました。最後に測定をして、探したい状態を取り出しましょう。',
      ),
      StudyStepText(
        title: '測定完了',
        message:
            '8個の候補の中から、少ない操作で目標の|111⟩を取り出すことができました。\nこのように、重ね合わせなどの量子特有の性質を使うことで、問題によって効率よく解くことができるのです。',
      ),
      StudyStepText(
        title: 'グローバーのアルゴリズム',
        message:
            '今回は3ビットで|111⟩を探しましたが、ビット数を増やし、目標状態に印をつける回路を設計すれば、より多くの候補の中から効率よく探索できます。\n量子コンピュータには、ほかにも面白いアルゴリズムがたくさんあります。ぜひこの先も調べて学んでみてください。',
      ),
    ],
    epilogueLead:
        'ここまでお疲れさまでした。盤面やブロッホ球で、量子の「手触り」が少しでもつかめたなら幸いです。',
    epiloguePhaseTitle: 'このアプリの位相の扱い',
    epiloguePhaseBullets: [
      '一般に量子状態の振幅は複素数ですが、このゲームで使っている初期状態とゲート（H, X, Y, Z, CNOT, SWAP, CCZ）の範囲では、虚数単位 i はグローバル位相としてのみ現れます。',
      'グローバル位相とは、状態ベクトルの全成分に共通して掛かる位相（e^{iφ}）のことです。これは測定確率や物理的な予測を変えないため、観測可能な違いを生みません。',
      'このゲームでは表示を分かりやすくするため、グローバル位相は常に 1 になるように取り直して表示しています。',
    ],
    epilogueLearnMoreTitle: 'さらに学ぶには',
    epilogueLearnMoreBody:
        'ここまでで少しでも興味を持ってくれたら、次は入門書や講義の動画等をのぞいてみてください。そこでは、このゲームで表現しきれなかった部分も、数式に基づき体系的に解説されています。量子のより深い理解へつながる一歩となれば幸いです。',
  );

  // ---------------------------------------------------------------------------
  // English
  // ---------------------------------------------------------------------------
  static const StudyContent en = StudyContent(
    bulletMark: '•',
    oneCellSteps: [
      StudyStepText(
        title: 'Quantum Computing with 1 Cell',
        message:
            'On this page, you\'ll get a feel for quantum states using the Bloch sphere and a probability amplitude graph on a 1-cell board, which represents a single qubit.',
      ),
      StudyStepText(
        title: 'Bloch Sphere',
        message:
            'The Bloch sphere shows the state of a qubit as a point on a sphere. Here, it\'s the blue dot.\nApplying a gate rotates that point around the matching axis.\nGo ahead and try one gate first.',
      ),
      StudyStepText(
        title: 'Applying Gates',
        message:
            'See how the blue dot rotated around the gate\'s axis? You can also swipe left and right to change your view of the Bloch sphere, so try the other gates too.',
      ),
      StudyStepText(
        title: 'Next: Probability Amplitude',
        message:
            'Now let\'s look at probability amplitude. Tap "Probability Amplitude" when you\'re ready.',
      ),
      StudyStepText(
        title: 'Probability Amplitude',
        message:
            'A qubit can sit somewhere between 0 and 1, and its state is described by complex numbers. A probability amplitude tells you how strongly 0 or 1 shows up when you measure the qubit.\nNote: In this game, we drop the global phase (the phase shared by every component), adjust the state so the first non-zero amplitude is a positive real number, and show the result as real amplitudes (-1 to 1).',
      ),
      StudyStepText(
        title: 'Probability',
        message:
            'Square a probability amplitude and you get the probability, which is the chance of seeing that outcome when you measure.\nTry different gates and compare each piece\'s probability amplitude with its probability.',
      ),
    ],
    twoCellSteps: [
      StudyStepText(
        title: 'Quantum Computing with 2 Cells',
        message:
            'On this page, you\'ll explore the state of two qubits through probability amplitudes and probabilities.',
      ),
      StudyStepText(
        title: 'Representing Two Qubits',
        message:
            'With one qubit, you had two options: the |0⟩ state or the |1⟩ state. With two qubits, the first can be |0⟩ or |1⟩ and so can the second, so together they make four possible states.\nIn notation like "|00⟩", where two digits sit inside | ⟩, the left digit is the first qubit and the right digit is the second.',
      ),
      StudyStepText(
        title: 'Try It Out',
        message:
            'Use this 2-cell board to apply gates, create superpositions, and entangle the cells. Watch how the state of the two qubits changes as you go.',
      ),
    ],
    threeCellSteps: [
      StudyStepText(
        title: 'Grover\'s Algorithm with 3 Cells',
        message:
            'On this page, you\'ll try out "Grover\'s algorithm," one of the algorithms unique to quantum computers, using a 3-cell board and three gates.',
      ),
      StudyStepText(
        title: 'What Is Grover\'s Algorithm?',
        message:
            'Grover\'s algorithm is a quantum algorithm that speeds up the "search problem": finding a specific value in a database with lots of entries. It really shines when you need to pick out one particular value from a huge pile of data.',
      ),
      StudyStepText(
        title: 'Number of States',
        message:
            'Here we\'ll apply the algorithm to 3 cells, which means 3 qubits. With 3 qubits, there are 2³ = 8 possible quantum states.',
      ),
      StudyStepText(
        title: 'The Target',
        message:
            'Our goal is to find the |111⟩ state among the 8 possibilities.',
      ),
      StudyStepText(
        title: 'A New Gate (CCZ)',
        message:
            'To find |111⟩, we need two new gates. First up is CCZ (Control-Control-Z). It works like CNOT (Control-X): it applies Z to the third bit only when the first and second bits are both black |1⟩. That lets us mark the |111⟩ we\'re looking for.',
      ),
      StudyStepText(
        title: 'A New Gate (Diff)',
        message:
            'The other is the Diff (Diffusion / inversion) gate. For this 3-qubit search for |111⟩, Diff can be built as the combined gate H→X→CCZ→X→H.\n[Diff = H→X→CCZ→X→H]\nIt flips each state\'s probability amplitude "around the average," which boosts the amplitude of the marked target state.',
      ),
      StudyStepText(
        title: 'Quantum Circuit',
        message:
            'Time to run the algorithm! Follow this quantum circuit and apply the gates to the board.',
      ),
      StudyStepText(
        title: 'Superposition',
        message:
            'Apply H to every cell to put the whole board into a superposition.',
      ),
      StudyStepText(
        title: 'Marking the Answer',
        message:
            'Following the circuit, CCZ marks the number we\'re looking for by flipping the sign of its probability amplitude.',
      ),
      StudyStepText(
        title: 'Inverting',
        message:
            'The Diff gate flips the marked number\'s probability amplitude around the average.',
      ),
      StudyStepText(
        title: 'One Round Complete',
        message:
            'You\'ve run Grover\'s algorithm once, and the probability of |111⟩ is now up to 78%. One more round will push the probability of our target state to its peak. Let\'s keep going!',
      ),
      StudyStepText(
        title: 'Two Rounds Complete',
        message:
            'After two rounds of Grover\'s algorithm, the probability is up to 95%. Now measure to pull out the state you\'re looking for.',
      ),
      StudyStepText(
        title: 'Measurement Complete',
        message:
            'Out of 8 candidates, we found the target |111⟩ in just a few steps.\nThat\'s the power of quantum properties like superposition: they can help solve certain problems efficiently.',
      ),
      StudyStepText(
        title: 'Grover\'s Algorithm',
        message:
            'We searched for |111⟩ with 3 qubits this time, but with more qubits and a circuit that marks the target state, you can search through far more candidates efficiently.\nQuantum computers have plenty of other fascinating algorithms, so keep exploring and learning!',
      ),
    ],
    epilogueLead:
        'Thanks for sticking with it! We hope the board and the Bloch sphere gave you at least a little feel for the quantum world.',
    epiloguePhaseTitle: 'How This App Handles Phase',
    epiloguePhaseBullets: [
      'In general, the amplitudes of a quantum state are complex numbers, but with the initial states and gates used in this game (H, X, Y, Z, CNOT, SWAP, CCZ), the imaginary unit i only ever shows up as a global phase.',
      'A global phase is a phase factor (e^{iφ}) that multiplies every component of the state vector. It doesn\'t change measurement probabilities or any physical prediction, so you can\'t observe it.',
      'To keep things easy to read, the game always adjusts the global phase to 1 before showing the state.',
    ],
    epilogueLearnMoreTitle: 'To Learn More',
    epilogueLearnMoreBody:
        'If this sparked your curiosity, try an introductory book or lecture videos next. They cover, step by step and with the math, the parts this game couldn\'t. We hope it\'s a step toward a deeper understanding of quantum computing.',
  );
}
