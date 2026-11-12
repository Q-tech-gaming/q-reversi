import 'dart:ui' show Locale;

import '../../l10n/content/tutorial_locale.dart';
import '../entities/tutorial_content.dart';
import '../entities/gate_type.dart';
import '../entities/challenge_level.dart';

/// チュートリアルサービス
///
/// 文言は [Locale]（ja / en）に応じて切り替える。ページ/スライドID・
/// 視覚要素・ページ構成はロケールに依存しない。
class TutorialService {
  /// レベル1のチュートリアルコンテンツを取得
  static List<TutorialContent> getLevel1Tutorial(Locale locale) {
    final t = tutorialTr(locale);
    return [
      // ① チャレンジモードの概念説明
      TutorialContent(
        id: 'level1_concept',
        title: t('量子の世界へようこそ', 'Welcome to the Quantum World'),
        description: t(
          'このゲームでは、コンピュータの量子を利用し、その量子でするリバーシゲームです。量子動作の特徴を活用し、原理を理解して量子世界を楽しもう',
          'This is Reversi powered by the quirks of quantum computing. Learn how quantum operations work and enjoy the quantum world!',
        ),
        type: TutorialType.concept,
      ),

      // ② Xゲートの説明
      TutorialContent(
        id: 'level1_xgate',
        title: t('Xゲート', 'X gate'),
        description: t(
          'Xゲートは白と黒の駒を入れ替えます',
          'The X gate swaps white and black pieces',
        ),
        type: TutorialType.gateExplain,
        gate: GateType.x,
        bulletPoints: [
          t('白 → 黒', 'White → Black'),
          t('黒 → 白', 'Black → White'),
        ],
      ),

      // ③ 操作説明（アニメーション付き）
      TutorialContent(
        id: 'level1_operation',
        title: t('操作方法', 'How to play'),
        description: t(
          'ゲートを選択して、盤面を選択し、適用ボタンを押します',
          'Pick a gate, select the target on the board, then tap the Apply button',
        ),
        type: TutorialType.operation,
        animation: const TutorialAnimation(
          type: AnimationType.operationDemo,
          duration: Duration(seconds: 5),
        ),
      ),
    ];
  }

  /// 新しいゲートが登場するレベルのチュートリアルを取得
  static List<TutorialContent>? getNewGateTutorial(
    int level,
    ChallengeLevel currentLevel,
    List<ChallengeLevel> allLevels,
    Locale locale,
  ) {
    final t = tutorialTr(locale);
    // 前のレベルで使用可能だったゲートを取得
    final previousGates = _getGatesUpToLevel(level - 1, allLevels);
    final currentGates = currentLevel.availableGates;

    // 新しいゲートを検出
    final newGates =
        currentGates.where((gate) => !previousGates.contains(gate)).toList();

    if (newGates.isEmpty) return null;

    // 最初の新しいゲートについて説明
    final newGate = newGates.first;
    return [
      TutorialContent(
        id: 'new_gate_${newGate.name}',
        title: t(
          '新しいゲート: ${_getGateName(newGate, locale)}',
          'New gate: ${_getGateName(newGate, locale)}',
        ),
        description: _getGateDescription(newGate, locale),
        type: TutorialType.gateExplain,
        gate: newGate,
        bulletPoints: _getGateBulletPoints(newGate, locale),
      ),
    ];
  }

  /// レベルまでのゲートを取得
  static List<GateType> _getGatesUpToLevel(
      int level, List<ChallengeLevel> allLevels) {
    final gates = <GateType>{};
    for (final l in allLevels) {
      if (l.level <= level) {
        gates.addAll(l.availableGates);
      }
    }
    return gates.toList();
  }

  /// ゲート名を取得
  static String _getGateName(GateType gate, Locale locale) {
    final t = tutorialTr(locale);
    switch (gate) {
      case GateType.x:
        return t('Xゲート', 'X gate');
      case GateType.h:
        return t('Hゲート', 'H gate');
      case GateType.y:
        return t('Yゲート', 'Y gate');
      case GateType.z:
        return t('Zゲート', 'Z gate');
      case GateType.cnot:
        return t('CNOTゲート', 'CNOT gate');
      case GateType.swap:
        return t('SWAPゲート', 'SWAP gate');
    }
  }

  /// ゲートの説明を取得
  static String _getGateDescription(GateType gate, Locale locale) {
    final t = tutorialTr(locale);
    switch (gate) {
      case GateType.x:
        return t(
          'Xゲートは白と黒の駒を入れ替えます',
          'The X gate swaps white and black pieces',
        );
      case GateType.h:
        return t(
          'Hゲートは重ね合わせ状態を作り出します',
          'The H gate creates a superposition',
        );
      case GateType.y:
        return t(
          'Yゲートは複数の変化を同時に行います',
          'The Y gate makes several changes at once',
        );
      case GateType.z:
        return t(
          'Zゲートは位相を反転させます',
          'The Z gate flips the phase',
        );
      case GateType.cnot:
        return t(
          'CNOTゲートは制御ビットに応じてターゲットビットを反転させます',
          'The CNOT gate flips the target bit based on the control bit',
        );
      case GateType.swap:
        return t(
          'SWAPゲートは2つの駒の状態を入れ替えます',
          'The SWAP gate swaps the states of two pieces',
        );
    }
  }

  /// ゲートの箇条書きを取得
  static List<String> _getGateBulletPoints(GateType gate, Locale locale) {
    final t = tutorialTr(locale);
    final white = t('白', 'White');
    final black = t('黒', 'Black');
    final grayPlus = t('グレープラス', 'Gray plus');
    final grayMinus = t('グレーマイナス', 'Gray minus');
    switch (gate) {
      case GateType.x:
        return ['$white → $black', '$black → $white'];
      case GateType.h:
        return [
          '$white → $grayPlus',
          '$black → $grayMinus',
          '$grayPlus → $white',
          '$grayMinus → $black',
        ];
      case GateType.y:
        return [
          '$white → $grayMinus',
          '$black → $grayPlus',
          '$grayPlus → $grayMinus',
          '$grayMinus → $grayPlus',
        ];
      case GateType.z:
        return [
          '$grayPlus → $grayMinus',
          '$grayMinus → $grayPlus',
          t('白・黒は変化なし', 'White and black are unchanged'),
        ];
      case GateType.cnot:
        return [
          t('制御ビットが黒の場合、ターゲットビットを反転',
              'If the control bit is black, the target bit flips'),
          t('制御ビットが白の場合は変化なし',
              'If the control bit is white, nothing changes'),
        ];
      case GateType.swap:
        return [
          t('2つの駒の状態を完全に入れ替え',
              'Fully swaps the states of the two pieces'),
        ];
    }
  }

  /// 全画面チュートリアルの全ページを取得（スライド制を廃止し、すべてのスライドを独立したページとして返す）
  static List<TutorialPage> getFullTutorial(Locale locale) {
    final t = tutorialTr(locale);
    final originalPages = _getOriginalTutorialPages(locale);

    // 指定されたページのみを残す
    const selectedSlideIds = [
      'welcome-1', // はじめに
      'operation-1', // ゲーム概要
      'piece_types-1', // 駒の種類
      'gate_about-1', // ゲートについて
      'gate_x-1', // Xゲート
      'gate_h-1', // Hゲート
      'gate_z-1', // Zゲート
      'gate_y-1', // Yゲート
      'gate_swap-1', // SWAPゲート
      'gate_cnot_1-1', // CNOTゲート
      'gate_mastery_complete-1', // ゲート習得完了
    ];
    final selectedTitles = [
      t('はじめに', 'Introduction'),
      t('ゲーム概要', 'Game overview'),
      t('駒の種類', 'Piece types'),
      t('ゲートについて', 'About gates'),
      t('Xゲート', 'X gate'),
      t('Hゲート', 'H gate'),
      t('Zゲート', 'Z gate'),
      t('Yゲート', 'Y gate'),
      t('SWAPゲート', 'SWAP gate'),
      t('CNOTゲート', 'CNOT gate'),
      t('ゲート説明完了', 'Gates explained'),
    ];

    final slideById = <String, TutorialSlide>{};
    for (final page in originalPages) {
      for (final slide in page.slides) {
        slideById[slide.slideId] = slide;
      }
    }

    final selectedPages = <TutorialPage>[];
    for (int i = 0; i < selectedSlideIds.length; i++) {
      final slideId = selectedSlideIds[i];
      final slide = slideById[slideId];
      if (slide == null) {
        throw StateError('Slide not found: $slideId');
      }
      selectedPages.add(
        TutorialPage(
          pageNumber: i + 1,
          pageId: slideId,
          pageTitle: selectedTitles[i],
          slides: [slide],
        ),
      );
    }

    return selectedPages;
  }

  /// 元のチュートリアルページリスト（スライド分割あり）
  static List<TutorialPage> _getOriginalTutorialPages(Locale locale) {
    final t = tutorialTr(locale);
    return [
      // ページ0: Welcome
      TutorialPage(
        pageNumber: 0,
        pageId: 'welcome',
        pageTitle: t('Welcomeページ', 'Welcome'),
        slides: [
          TutorialSlide(
            slideId: 'welcome-1',
            texts: [
              t('量子の世界へようこそ。', 'Welcome to the quantum world.'),
              t(
                'このゲームは、量子コンピュータの動作原理を活用したリバーシ風ゲームです。',
                'This is a Reversi-style game powered by how quantum computers actually work.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/QC_and_Othello.jpg'},
            ),
          ),
        ],
      ),

      // ページ1: 基本操作
      TutorialPage(
        pageNumber: 1,
        pageId: 'operation',
        pageTitle: t('基本操作', 'Basic controls'),
        slides: [
          TutorialSlide(
            slideId: 'operation-1',
            texts: [
              t(
                '8x8の盤面のそれぞれのマスにある駒を量子コンピュータの最小単位(量子ビット)として、その盤面の縦横1列、もしくは正方4マスに対して量子コンピュータの演算(量子ゲート)をかけていくゲームです。',
                'Every piece on the 8x8 board is a qubit, the smallest unit of a quantum computer. You play by applying quantum gates, the operations of a quantum computer, to a single row, a single column, or a 2x2 block of four cells.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.animation,
              data: {'type': 'operation_demo'},
            ),
          ),
        ],
      ),

      // ページ1.5: 量子コンピュータとは？
      TutorialPage(
        pageNumber: 1,
        pageId: 'quantum_computer_intro',
        pageTitle: t('量子コンピュータとは？', 'What is a quantum computer?'),
        slides: [
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
        ],
      ),

      // ページ2: 量子コンピュータの最小単位(qビット)
      TutorialPage(
        pageNumber: 2,
        pageId: 'qbit',
        pageTitle: t(
          '量子コンピュータの最小単位(qビット)',
          'The building block of a quantum computer (qubit)',
        ),
        slides: [
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
        ],
      ),

      // ページ3: 重ね合わせについて
      TutorialPage(
        pageNumber: 3,
        pageId: 'superposition',
        pageTitle: t('重ね合わせについて', 'About superposition'),
        slides: [
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
                'このゲームでは、グレー駒は測定すると50%の確率で白(0)か黒(1)に確定するものとします。',
                'In this game, a measured gray piece has a 50/50 chance of becoming white (0) or black (1).',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.diagram,
              data: {'type': 'measurement'},
            ),
          ),
        ],
      ),

      // ページ4: 駒の種類 / ゲートについて
      TutorialPage(
        pageNumber: 4,
        pageId: 'piece_and_gate_intro',
        pageTitle: t('駒の種類 / ゲートについて', 'Piece types / About gates'),
        slides: [
          TutorialSlide(
            slideId: 'piece_types-1',
            texts: [
              t(
                'このゲームでは、普通のリバーシと同じ白と黒だけでなく、その中間の状態を表すグレープラス、グレーマイナスという駒があります。グレーの駒は、対戦終了時に50%の確率で白か黒になります。',
                'Along with the white and black pieces from regular Reversi, this game has gray plus and gray minus pieces for in-between states. When the match ends, each gray piece becomes white or black on a 50/50 chance.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.diagram,
              data: {'type': 'piece_kinds'},
            ),
          ),
          TutorialSlide(
            slideId: 'gate_about-1',
            texts: [
              t(
                'このゲームでは、駒を挟んでひっくり返す代わりに、量子コンピュータの演算である"ゲート"を駒に適用して別の種類の駒に変化させます。以下の6つのゲートを用います。',
                'Instead of flanking and flipping pieces, you apply "gates," the operations of a quantum computer, to turn pieces into other kinds of pieces. Here are the six gates you\'ll use.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/GateKinds.png'},
            ),
          ),
        ],
      ),

      // ページ5: Xゲート
      TutorialPage(
        pageNumber: 5,
        pageId: 'gate_x',
        pageTitle: t('Xゲート', 'X gate'),
        slides: [
          TutorialSlide(
            slideId: 'gate_x-1',
            texts: [
              t(
                '1つのビットに作用し、白と黒を入れ替えます。',
                'Acts on one piece and swaps white and black.',
              ),
              t('グレー駒は変化させません。', 'Gray pieces stay as they are.'),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/gateX.png'},
            ),
          ),
        ],
      ),

      // ページ6: Hゲート
      TutorialPage(
        pageNumber: 6,
        pageId: 'gate_h',
        pageTitle: t('Hゲート', 'H gate'),
        slides: [
          TutorialSlide(
            slideId: 'gate_h-1',
            texts: [
              t(
                '1つのビットに作用し、白とグレープラス、黒とグレーマイナスを入れ替えます。',
                'Acts on one piece and swaps white with gray plus, and black with gray minus.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/gateH.png'},
            ),
          ),
        ],
      ),

      // ページ7: Zゲート
      TutorialPage(
        pageNumber: 7,
        pageId: 'gate_z',
        pageTitle: t('Zゲート', 'Z gate'),
        slides: [
          TutorialSlide(
            slideId: 'gate_z-1',
            texts: [
              t(
                '1つのビットに作用し、グレープラスとグレーマイナスを入れ替えます。',
                'Acts on one piece and swaps gray plus and gray minus.',
              ),
              t('白と黒は変化させません。', 'White and black stay as they are.'),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/gateZ.png'},
            ),
          ),
        ],
      ),

      // ページ8: Yゲート
      TutorialPage(
        pageNumber: 8,
        pageId: 'gate_y',
        pageTitle: t('Yゲート', 'Y gate'),
        slides: [
          TutorialSlide(
            slideId: 'gate_y-1',
            texts: [
              t(
                '1つのビットに作用し、白と黒、グレープラスとグレーマイナスを入れ替えます。',
                'Acts on one piece and swaps white with black, and gray plus with gray minus.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/gateY.png'},
            ),
          ),
        ],
      ),

      // ページ9: SWAPゲート
      TutorialPage(
        pageNumber: 9,
        pageId: 'gate_swap',
        pageTitle: t('SWAPゲート', 'SWAP gate'),
        slides: [
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
        ],
      ),

      // ページ10: CNOTゲート#1 - 基本動作
      TutorialPage(
        pageNumber: 10,
        pageId: 'gate_cnot_1',
        pageTitle: t('CNOTゲート#1 - 基本動作', 'CNOT gate #1 - Basic behavior'),
        slides: [
          TutorialSlide(
            slideId: 'gate_cnot_1-1',
            texts: [
              t(
                '2つの隣接する駒に作用し、1駒目が黒の時のみ、2駒目にXゲートが作用(白と黒を入れ替え)します。',
                'Acts on two adjacent pieces. Only when the first piece is black is the X gate applied to the second piece (swapping white and black).',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/gateCNOT.png'},
            ),
          ),
        ],
      ),

      // ページ10.5: ゲート習得完了
      TutorialPage(
        pageNumber: 10,
        pageId: 'gate_mastery_complete',
        pageTitle: t('チュートリアル完了', 'Tutorial complete'),
        slides: [
          TutorialSlide(
            slideId: 'gate_mastery_complete-1',
            texts: [
              t(
                '基本操作の説明はこれで完了です。',
                'That covers the basic controls!',
              ),
              t(
                '続きはチャレンジモードの「ステージ0」で、実際に手を動かしながら練習できます。',
                'Keep practicing hands-on in "Stage 0" of Challenge Mode.',
              ),
              t(
                '下の「チャレンジへ」から、チュートリアルの続きを始めましょう。',
                'Tap "Go to Challenge" below to continue the tutorial.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/AllGate.png'},
            ),
          ),
        ],
      ),

      // ページ11: CNOTゲート#2 - エンタングルメント
      TutorialPage(
        pageNumber: 11,
        pageId: 'gate_cnot_2',
        pageTitle:
            t('CNOTゲート#2 - エンタングルメント', 'CNOT gate #2 - Entanglement'),
        slides: [
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
                'このような状態を"エンタングルメント"と呼び、このゲームでは以下の通りに表現することとします。',
                'This kind of state is called "entanglement," and here\'s how the game shows it.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.image,
              data: {'path': 'assets/entanglement.png'},
            ),
          ),
        ],
      ),

      // ページ12: CNOTゲート#3 - 全パターン一覧
      TutorialPage(
        pageNumber: 12,
        pageId: 'gate_cnot_3',
        pageTitle: t(
          'CNOTゲート#3 - 全パターン一覧',
          'CNOT gate #3 - All patterns',
        ),
        slides: [
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
        ],
      ),

      // ページ13: 終わりに
      TutorialPage(
        pageNumber: 13,
        pageId: 'finish',
        pageTitle: t('終わりに', 'Epilogue'),
        slides: [
          TutorialSlide(
            slideId: 'finish-1',
            texts: [
              t(
                '量子コンピュータでは、重ね合わせとエンタングルメントをうまく回路の中で使うことで、高速な計算が可能になるのです。',
                'By making clever use of superposition and entanglement in its circuits, a quantum computer can solve certain problems much faster.',
              ),
              t(
                'まずはチャレンジモードのステージ0（チュートリアルの続き）で操作を固め、クリア後は本編ステージへ進んでみてください。',
                'Start by getting comfortable with the controls in Challenge Mode Stage 0 (the rest of the tutorial), then head into the main stages once you clear it.',
              ),
            ],
            visualElement: const TutorialVisualElement(
              type: VisualElementType.board,
            ),
          ),
        ],
      ),
    ];
  }
}
