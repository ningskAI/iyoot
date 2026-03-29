import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyoot/collections/app_style.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:iyoot/models/database/database.dart';
import 'package:iyoot/provider/database.dart';
import 'package:iyoot/provider/user_preferences_provider.dart';
import 'package:iyoot/routes/routes.dart';
import 'package:iyoot/services/logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. 获取设备物理尺寸并判断
  final view = PlatformDispatcher.instance.views.first;
  final size = view.physicalSize / view.devicePixelRatio;
  final isTablet = size.shortestSide >= 600;

  if (isTablet) {
    // Pad 设备强制横屏
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    // 手机设备（暂不支持）：这里也可以锁定方向，或者在 Widget 层拦截
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  final database = AppDatabase();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  
  // 设置状态栏为透明
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
      child: const iYoot(),
    ),
  );
}

class iYoot extends ConsumerWidget {
  const iYoot({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(userPreferencesProvider.select((s) => s.themeMode));
    final locale = ref.watch(userPreferencesProvider.select((s) => s.locale));
    
    // 2. 在 UI 层再次确认，如果不是平板则显示不支持提示
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppStyle.lightTheme,
        darkTheme: AppStyle.darkTheme,
        themeMode: themeMode,
        home: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.tablet_android, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('阅然：本应用仅支持平板设备使用', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      );
    }

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
