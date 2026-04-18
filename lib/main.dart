import 'dart:io';
import 'dart:ui';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/data/database/app_database.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/providers/user_preferences_provider.dart';
import 'package:i_reader/core/routes/routes.dart';
import 'package:i_reader/services/logger/logger.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.instance.database;

  // 2. 屏幕方向锁定逻辑
  final view = PlatformDispatcher.instance.views.first;
  final size = view.physicalSize / view.devicePixelRatio;
  final isTablet = size.shortestSide >= 600;

  if (isTablet) {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } else {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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
    final themeMode = ThemeMode.dark;

    // 判定亮暗模式
    final brightness = MediaQuery.platformBrightnessOf(context);
    final bool isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system && brightness == Brightness.dark);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    final width = MediaQuery.of(context).size.width;

    // 拦截页面逻辑
    if (width < 600) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        color: const Color(0xFF1A1A1A),
        theme: AppStyle.lightTheme,
        darkTheme: AppStyle.darkTheme,
        themeMode: themeMode,
        home: Scaffold(
          backgroundColor: const Color(0xFF1A1A1A),
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '『尺幅局促，难容碎金。\n案头之书，须有舒展之所。\n检测到当前设备画幅受限，避难所大门暂不开启。\n待君执平板而来，再续书缘。』',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontFamily: 'serif',
                          fontSize: 18,
                          height: 2.2,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () => exit(0),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFF2F2F2).withOpacity(0.3),
                    ),
                    child: const Text(
                      '退出程序',
                      style: TextStyle(
                        fontFamily: 'serif',
                        letterSpacing: 4,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'iyoot',
      color: isDark ? Colors.black : AppColors.paper, // 匹配底色，防止闪烁
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
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
    );
  }
}
