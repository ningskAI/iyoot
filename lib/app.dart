import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/core/routes/routes.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final theme = ref.watch(appThemeProvider);
    final tdTheme = ref.watch(tdThemeProvider);

    return TDTheme(
      data: tdTheme,
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'iReader',
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.invertedStylus,
              },
            ),
            child: child!,
          );
        },
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        themeMode: themeMode,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
      ),
    );
  }
}
