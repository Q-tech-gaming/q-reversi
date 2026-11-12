import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_navigator.dart';
import 'core/background_music.dart';
import 'core/sound_effects.dart';
import 'data/firebase/firebase_bootstrap.dart';
import 'data/firebase/time_attack_pending_submit_retry.dart';
import 'l10n/app_localizations.dart';
import 'presentation/gate_effect_icon_setting.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await FirebaseBootstrap.initialize();
    FirebaseBootstrap.logInitResult();
    // 起動をブロックしすぎないよう、pending 再送は待たずに走らせる
    unawaited(TimeAttackPendingSubmitRetry().tryFlush());
  } catch (e, st) {
    debugPrint('Firebase 初期化に失敗しました: $e\n$st');
  }
  try {
    await SoundEffects.instance.prepare();
  } catch (e, st) {
    debugPrint('効果音の準備に失敗しました: $e\n$st');
  }
  try {
    await BackgroundMusic.instance.prepare();
  } catch (e, st) {
    debugPrint('BGM の準備に失敗しました: $e\n$st');
  }
  try {
    await GateEffectIconSetting.instance.load();
  } catch (e, st) {
    debugPrint('ゲート表示設定の読み込みに失敗しました: $e\n$st');
  }
  runApp(const QReversiApp());
}

class QReversiApp extends StatelessWidget {
  const QReversiApp({super.key});

  /// 開発時の言語固定。優先順位:
  /// 1. `--dart-define=APP_LOCALE=en|ja`
  /// 2. Web の `?lang=en|ja`
  /// 未指定なら端末/ブラウザ言語に従う。
  static Locale? _forcedLocale() {
    const fromDefine = String.fromEnvironment('APP_LOCALE');
    if (fromDefine == 'en' || fromDefine == 'ja') {
      return Locale(fromDefine);
    }
    final fromQuery = Uri.base.queryParameters['lang'];
    if (fromQuery == 'en' || fromQuery == 'ja') {
      return Locale(fromQuery!);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.key,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.darkTheme,
      locale: _forcedLocale(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale?.languageCode == 'ja') {
          return const Locale('ja');
        }
        return const Locale('en');
      },
      // Web のアドレスバーに残った深いパスを初期ルートにしない
      initialRoute: '/',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
