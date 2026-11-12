import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:q_reversi_app/domain/entities/tutorial_content.dart';
import 'package:q_reversi_app/domain/services/study_quantum_intro_tutorial_service.dart';
import 'package:q_reversi_app/domain/services/tutorial_service.dart';

final _japanese = RegExp(r'[ぁ-んァ-ン一-龥]');

Iterable<String> _texts(List<TutorialPage> pages) sync* {
  for (final page in pages) {
    yield page.pageTitle;
    for (final slide in page.slides) {
      yield* slide.texts;
    }
  }
}

void main() {
  const ja = Locale('ja');
  const en = Locale('en');

  test('全画面チュートリアルは ja/en で同じ構成（ID・視覚要素）になる', () {
    final jaPages = TutorialService.getFullTutorial(ja);
    final enPages = TutorialService.getFullTutorial(en);
    expect(enPages.length, jaPages.length);
    for (var i = 0; i < jaPages.length; i++) {
      expect(enPages[i].pageId, jaPages[i].pageId);
      expect(enPages[i].slides.length, jaPages[i].slides.length);
      for (var s = 0; s < jaPages[i].slides.length; s++) {
        final a = jaPages[i].slides[s];
        final b = enPages[i].slides[s];
        expect(b.slideId, a.slideId);
        expect(b.texts.length, a.texts.length);
        expect(b.visualElement?.type, a.visualElement?.type);
        expect(b.visualElement?.data, a.visualElement?.data);
      }
    }
    expect(_texts(jaPages).any(_japanese.hasMatch), isTrue);
    expect(_texts(enPages).any(_japanese.hasMatch), isFalse);
  });

  test('スタディ導入は ja/en で同じ構成になり、英語に日本語が残らない', () {
    final jaPages = StudyQuantumIntroTutorialService.getPages(ja);
    final enPages = StudyQuantumIntroTutorialService.getPages(en);
    expect(enPages.length, jaPages.length);
    for (var i = 0; i < jaPages.length; i++) {
      expect(enPages[i].pageId, jaPages[i].pageId);
      expect(enPages[i].slides.single.texts.length,
          jaPages[i].slides.single.texts.length);
    }
    expect(_texts(enPages).any(_japanese.hasMatch), isFalse);
  });

  test('レベル1チュートリアルに英語で日本語が残らない', () {
    final enContents = TutorialService.getLevel1Tutorial(en);
    expect(enContents.length, TutorialService.getLevel1Tutorial(ja).length);
    for (final content in enContents) {
      expect(_japanese.hasMatch(content.title), isFalse);
      expect(_japanese.hasMatch(content.description), isFalse);
      for (final point in content.bulletPoints ?? const <String>[]) {
        expect(_japanese.hasMatch(point), isFalse);
      }
    }
  });
}
