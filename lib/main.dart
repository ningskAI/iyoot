import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/data/database/app_database.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/core/routes/routes.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/services/logger/logger.dart';
import 'package:i_reader/services/startup/app_startup_coordinator.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await AppDatabase.instance.database;
  await AppStartupCoordinator.initialize();
  await readService(AppServices.webserviceManager).start();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    ProviderScope(
      observers: const [AppLoggerProviderObserver()],
      child: iYoot(), // 将预加载的数据传入
    ),
  );
}

class iYoot extends ConsumerStatefulWidget {
  const iYoot({super.key});

  @override
  ConsumerState<iYoot> createState() => _iYootState();
}

class _iYootState extends ConsumerState<iYoot> {
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
        title: 'iyoot',
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
