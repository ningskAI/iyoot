import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/app_style.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:iyoot/models/database/database.dart';
import 'package:iyoot/provider/database.dart';
import 'package:iyoot/provider/user_preferences_provider.dart';
import 'package:iyoot/routes/routes.dart';
import 'package:iyoot/services/logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWith((ref) => database),
      ],
      observers: const [
        AppLoggerProviderObserver(),
      ],
      child: iYoot(),
    ),
  );
}


class iYoot extends HookConsumerWidget {

  const iYoot({super.key});


  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(userPreferencesProvider.select((s) => s.themeMode));
    final locale = ref.watch(userPreferencesProvider.select((s) => s.locale));
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'iyoot',
      builder: (context, child) {
        child = ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
            }
          ),
          child: child!,
        );

        return child;
      },
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: themeMode,
      locale: locale.languageCode == "system" ? null : locale,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
    );

  }

}
