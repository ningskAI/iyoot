import 'dart:io';
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
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(userPreferencesProvider.select((s) => s.themeMode));
    final locale = ref.watch(userPreferencesProvider.select((s) => s.locale));
    
    // 2. 拦截逻辑：当画幅宽度小于 600 时触发
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppStyle.lightTheme,
        darkTheme: AppStyle.darkTheme,
        themeMode: themeMode,
        home: Scaffold(
          backgroundColor: const Color(0xFF1A1A1A), // 纯黑
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
                        '『尺幅局促，难容碎金。\n'
                        '案头之书，须有舒展之所。\n'
                        '检测到当前设备画幅受限，避难所大门暂不开启。\n'
                        '待君执平板而来，再续书缘。』',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2), // 玄纸白
                          fontFamily: 'serif', // 宋体
                          fontSize: 18,
                          height: 2.2, // 呼吸感行高
                          letterSpacing: 2.0, // 呼吸感字间距
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
                      foregroundColor: const Color(0xFFF2F2F2).withOpacity(0.3), // 半透明按钮
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
