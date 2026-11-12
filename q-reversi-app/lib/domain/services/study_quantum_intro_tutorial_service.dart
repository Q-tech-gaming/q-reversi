import 'dart:ui' show Locale;

import '../../l10n/content/tutorial_locale.dart';
import '../entities/tutorial_content.dart';

/// スタディ「量子コンピュータとは？」専用のチュートリアルデータ。
///
/// 全体チュートリアルとは独立したスライド定義を持たせることで、
/// 相互の変更影響を抑える。文言は [Locale]（ja / en）に応じて切り替える。
class StudyQuantumIntroTutorialService {
  static List<TutorialPage> getPages(Locale locale) {
    final t = tutorialTr(locale);

    // ブラケット記法（|0⟩ など）。折り返しで分断されないよう WORD JOINER を挟む。
    const ket0 = '|\u20600\u2060⟩';
    const ket1 = '|\u20601\u2060⟩';
    const ketPlus = '|\u2060+\u2060⟩';
    const ketMinus = '|\u2060-\u2060⟩';

    final selectedSlides = <TutorialSlide>[
      TutorialSlide(
        slideId: 'quantum_computer_intro-1',
        texts: [
          t(
            '「原子よりも小さな粒子の世界の不思議なルール」="量子力学"の性質を活用することで、従来のコンピュータでは解けない複雑な問題を高速に計算できるコンピュータです。',
            'Quantum computers tap into "quantum mechanics," the strange rules of a world smaller than atoms, to quickly solve complex problems that conventional computers can\'t.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/Quantum.jpg'},
        ),
      ),
      TutorialSlide(
        slideId: 'qbit-1',
        texts: [
          t(
            '従来のコンピュータでは、その最小単位(ビット)は0か1のどちらかの値を取ります。',
            'In a conventional computer, the smallest unit, a bit, is either 0 or 1.',
          ),
          t(
            '量子コンピュータの最小単位(量子ビット)では、1ビットが0か1だけではなく、その中間の状態(重ね合わせの状態)が存在し、0か1が確定していない中間の状態を取ることができます。',
            'A quantum computer\'s smallest unit, a qubit, can be 0, 1, or something in between (a superposition), where it hasn\'t settled on 0 or 1 yet.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.comparison,
        ),
      ),
      TutorialSlide(
        slideId: 'qbit-2',
        texts: [
          t(
            'このゲームでは、0を白駒、1を黒駒、そして重ね合わせの状態をグレー駒として、量子コンピュータの中身を模擬します。',
            'In this game, a white piece stands for 0, a black piece for 1, and a gray piece for a superposition. That\'s how we mimic what goes on inside a quantum computer.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.board,
          data: {'mode': 'mini_board_with_image'},
        ),
      ),
      TutorialSlide(
        slideId: 'study_piece_kinds-1',
        texts: [
          t(
            '量子の世界では、白の状態を$ket0、黒の状態を$ket1、グレープラスの状態を$ketPlus、グレーマイナスの状態を$ketMinusという形で表現します。',
            'In quantum notation, the white state is written as $ket0, the black state as $ket1, the gray plus state as $ketPlus, and the gray minus state as $ketMinus.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.diagram,
          data: {
            'type': 'piece_kinds',
            'variant': 'bra_ket',
          },
        ),
      ),
      TutorialSlide(
        slideId: 'superposition-1',
        texts: [
          t(
            'さて、このグレー駒の状態とは、どういう状態でしょうか？',
            'So, what state is a gray piece in?',
          ),
          t(
            '例えば、コイントスをして空中で回っている最中のような、白(0)か黒(1)にまだ確定しておらず、どちらになる可能性もあるような状態のことを指しています。',
            'Think of a coin spinning in the air after a toss: it hasn\'t landed on white (0) or black (1) yet, and it could end up either way.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.diagram,
          data: {'type': 'gray_piece_equals_video'},
        ),
      ),
      TutorialSlide(
        slideId: 'superposition-2',
        texts: [
          t(
            'グレー駒がどちらの色に転んだかは、量子コンピュータの操作、"測定"をすることで、白(0)か黒(1)に確定し、計算結果を得ることができます。',
            'A gray piece settles on a color when you perform an operation called "measurement." Measuring turns it into white (0) or black (1) and gives you the result of the computation.',
          ),
          t(
            'このゲームでは、グレー駒は測定すると50%の確率で白(0)か黒(1)に確定するものとしています。',
            'In this game, a measured gray piece has a 50/50 chance of becoming white (0) or black (1).',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.diagram,
          data: {'type': 'measurement'},
        ),
      ),
      TutorialSlide(
        slideId: 'study_gate_intro-1',
        texts: [
          t(
            '次に、ゲートと呼ばれるコンピュータへの演算操作について説明します。',
            'Next, let\'s talk about gates, the operations a computer applies to bits.',
          ),
          t(
            '従来のコンピュータでは、1つのビットを反転させる(NOTゲート)、2つのビットがどちらも1であれば1になる(ANDゲート)、2つのビットのどちらかが1であれば1になる(ORゲート)といった、1ビットや2ビットに作用させるゲートを使って、計算処理を実行しています。',
            'A conventional computer does its computing with gates that act on one or two bits: flipping a bit (NOT gate), outputting 1 only if both bits are 1 (AND gate), or outputting 1 if at least one bit is 1 (OR gate).',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateExample.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'study_gate_intro-2',
        texts: [
          t(
            '量子コンピュータにも、量子ゲートと呼ばれる、量子ビットに作用させる演算操作があります。',
            'Quantum computers have their own operations for qubits, called quantum gates.',
          ),
          t(
            'このゲームでは、代表的な量子ゲートを使用しています。',
            'This game features some of the most common quantum gates.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/QC_Gate.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_x-1',
        texts: [
          t(
            '1つのビットに作用し、白$ket0と黒$ket1を入れ替えます。',
            'Acts on one piece and swaps white $ket0 and black $ket1.',
          ),
          t('グレー駒は変化させません。', 'Gray pieces stay as they are.'),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateX.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_h-1',
        texts: [
          t(
            '1つのビットに作用し、白$ket0とグレープラス$ketPlus、黒$ket1とグレーマイナス$ketMinusを入れ替えます。',
            'Acts on one piece and swaps white $ket0 with gray plus $ketPlus, and black $ket1 with gray minus $ketMinus.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateH.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_z-1',
        texts: [
          t(
            '1つのビットに作用し、グレープラス$ketPlusとグレーマイナス$ketMinusを入れ替えます。',
            'Acts on one piece and swaps gray plus $ketPlus and gray minus $ketMinus.',
          ),
          t('白と黒は変化させません。', 'White and black stay as they are.'),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateZ.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_y-1',
        texts: [
          t(
            '1つのビットに作用し、白$ket0と黒$ket1、グレープラス$ketPlusとグレーマイナス$ketMinusを入れ替えます。',
            'Acts on one piece and swaps white $ket0 with black $ket1, and gray plus $ketPlus with gray minus $ketMinus.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateY.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_swap-1',
        texts: [
          t(
            '2つの隣接する駒に作用し、その駒を入れ替えます。',
            'Acts on two adjacent pieces and swaps them.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateSWAP.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'study_gate_cnot_1-1',
        texts: [
          t(
            'CNOTゲートはControl-NOT(コントロール・ノット)の略で、別名Control-X(コントロール・X)とも呼ばれます。\n2つの隣接する駒に作用し、1ビット目(制御ビット)が黒$ket1の時のみ、2ビット目(ターゲットビット)にXゲートの効果(白と黒の入れ替え)を適用します。',
            'CNOT is short for Controlled-NOT, and it\'s also known as Controlled-X.\nIt acts on two adjacent pieces. Only when the first bit (the control bit) is black $ket1 does it apply the X gate\'s effect (swapping white and black) to the second bit (the target bit).',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/gateCNOT.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_cnot_2-1',
        texts: [
          t(
            'さて、ここでCNOTゲートについて少し深く考えてみます。1駒目が黒や白ではなく、グレーだった場合はどうなるでしょう？',
            'Let\'s take a closer look at the CNOT gate. What happens if the first piece is gray instead of black or white?',
          ),
          t(
            'グレーの場合、50%で白、50%で黒なので、2駒目が反転するかどうかも確率的になります。',
            'A gray piece is 50% white and 50% black, so whether the second piece flips is a matter of chance, too.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/CNOTgray.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_cnot_2-2',
        texts: [
          t(
            '例えば、1駒目が白だった時、2駒目は反転せず白のままです。1駒目が黒だった時、2駒目は反転しており、黒になります。',
            'For example, if the first piece is white, the second piece doesn\'t flip and stays white. If the first piece is black, the second piece flips and becomes black.',
          ),
          t(
            'このように、測定するまではどちらかわからないが、1駒目を測定して白なら、2駒目も必ず白。1駒目を測定して黒なら2駒目も必ず黒。というように運命を共にした状態になるのです。',
            'You can\'t tell which outcome you\'ll get until you measure. But if the first piece measures white, the second is always white, and if the first measures black, the second is always black. The two pieces are bound to the same fate.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/CNOT3.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_cnot_2-3',
        texts: [
          t(
            'このような状態を"エンタングルメント(量子もつれ)"と呼び、このゲームでは以下の通りに表現することとします。',
            'This kind of state is called "entanglement," and here\'s how the game shows it.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/entanglement.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_cnot_3-1',
        texts: [
          t(
            '最後に、CNOTゲートの2駒の組み合わせ全パターンです。',
            'Last up: every possible combination of two pieces for the CNOT gate.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/blackCNOT_all.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'gate_cnot_3-2',
        texts: [
          t(
            'VSモードにおける黒プレイヤーの場合は、1駒目の条件が反転することとします。',
            'In VS mode, the condition on the first piece is reversed for the black player.',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.image,
          data: {'path': 'assets/whiteCNOT_all.png'},
        ),
      ),
      TutorialSlide(
        slideId: 'finish-1',
        texts: [
          t(
            '量子コンピュータでは、重ね合わせとエンタングルメントをうまく回路の中で使うことで、高速な計算が可能になるのです。',
            'By making clever use of superposition and entanglement in its circuits, a quantum computer can solve certain problems much faster.',
          ),
          t(
            'スタディモードの次のステップに進んで、量子コンピュータと量子アルゴリズムの一端を感じてみてください...!',
            'Head to the next step in Study Mode to get a taste of quantum computers and quantum algorithms!',
          ),
        ],
        visualElement: const TutorialVisualElement(
          type: VisualElementType.board,
        ),
      ),
    ];

    final selectedTitles = [
      t('量子コンピュータとは？', 'What is a quantum computer?'),
      t('量子ビット', 'Qubit'),
      t('Qリバーシ', 'Q-Reversi'),
      t('駒の種類', 'Piece types'),
      t('グレー駒の状態', 'State of gray pieces'),
      t('測定', 'Measurement'),
      t('ゲート', 'Gates'),
      t('量子ゲート', 'Quantum gates'),
      t('Xゲート', 'X gate'),
      t('Hゲート', 'H gate'),
      t('Zゲート', 'Z gate'),
      t('Yゲート', 'Y gate'),
      t('SWAPゲート', 'SWAP gate'),
      t('CNOTゲート', 'CNOT gate'),
      t('CNOTゲート(発展)', 'CNOT gate (advanced)'),
      t('CNOTゲート(発展)', 'CNOT gate (advanced)'),
      t('エンタングルメント', 'Entanglement'),
      t('CNOT全パターン[プレイヤー白]', 'CNOT all patterns [White player]'),
      t('CNOT全パターン[プレイヤー黒]', 'CNOT all patterns [Black player]'),
      t('終わりに', 'Epilogue'),
    ];

    final pages = <TutorialPage>[];
    for (int i = 0; i < selectedSlides.length; i++) {
      pages.add(
        TutorialPage(
          pageNumber: i + 3,
          pageId: selectedSlides[i].slideId,
          pageTitle: selectedTitles[i],
          slides: [selectedSlides[i]],
        ),
      );
    }
    return pages;
  }
}
