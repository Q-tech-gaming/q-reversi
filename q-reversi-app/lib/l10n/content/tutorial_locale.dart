import 'dart:ui' show Locale;

/// チュートリアル長文コンテンツ用の簡易ロケール選択ヘルパー。
///
/// アプリは ja / en のみをサポートしている（`localeResolutionCallback` で
/// ja 以外は en にフォールバックする）ため、ここでも ja 以外は英語として扱う。

/// 日本語ロケールかどうか。
bool isJapaneseLocale(Locale locale) => locale.languageCode == 'ja';

/// 日本語/英語の文字列を選ぶ関数型。
typedef TutorialTr = String Function(String ja, String en);

/// [locale] に応じて ja / en の文字列を返す関数を作る。
TutorialTr tutorialTr(Locale locale) {
  final japanese = isJapaneseLocale(locale);
  return (String ja, String en) => japanese ? ja : en;
}
