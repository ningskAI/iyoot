import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iyoot/app/app_style.dart';
import 'package:iyoot/app/log.dart';
import 'package:iyoot/app/utils.dart';
import 'package:iyoot/common/core_log.dart';
import 'package:iyoot/models/common/theme/theme_color_type.dart';
import 'package:iyoot/pages/other/debug_log_page.dart';
import 'package:iyoot/routes/app_pages.dart';
import 'package:iyoot/routes/route_path.dart';
import 'package:iyoot/utils/extension/theme_ext.dart';
import 'package:iyoot/utils/path_utils.dart';
import 'package:iyoot/utils/platform_utils.dart';
import 'package:iyoot/utils/storage.dart';
import 'package:iyoot/utils/storage_key.dart';
import 'package:iyoot/utils/storage_pref.dart';
import 'package:iyoot/utils/theme_utils.dart';
import 'package:iyoot/widgets/status/app_loadding_widget.dart';
import 'package:logger/logger.dart';
import 'package:media_kit/media_kit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

import 'package:path/path.dart' as p;
import 'package:dynamic_color/dynamic_color.dart';
import 'package:iyoot/utils/listen_fourth_button.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initAppPath();
  try {
    await GSStorage.init();
  } catch(e) {
    await Utils.copyText(e.toString());
    if (kReleaseMode) {
      debugPrint('GStorage init error: $e');
      exit(0);
    }
  }
  await Future.wait([_initDownPath(), _initTmpPath()]);
  await _initWindow();
  MediaKit.ensureInitialized();
  _initCoreLog();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //设置状态栏为透明
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(const MyApp());
}

Future<void> _initDownPath() async {
  if (PlatformUtils.isDesktop) {
    final customDownPath = Pref.downloadPath;
    if (customDownPath != null && customDownPath.isNotEmpty) {
      try {
        final dir = Directory(customDownPath);
        if (!dir.existsSync()) {
          await dir.create(recursive: true);
        }
        downloadPath = customDownPath;
      } catch (e) {
        downloadPath = defDownloadPath;
        await GSStorage.setting.delete(SettingBoxKey.downloadPath);
        if (kDebugMode) {
          debugPrint('download path error: $e');
        }
      }
    } else {
      downloadPath = defDownloadPath;
    }
  } else if (Platform.isAndroid) {
    final externalStorageDirPath = (await getExternalStorageDirectory())?.path;
    downloadPath = externalStorageDirPath != null
        ? p.join(externalStorageDirPath, PathUtils.downloadDir)
        : defDownloadPath;
  } else {
    downloadPath = defDownloadPath;
  }
}

Future<void> _initTmpPath() async {
  tmpDirPath = (await getTemporaryDirectory()).path;
}

Future<void> _initAppPath() async {
  appSupportDirPath = (await getApplicationSupportDirectory()).path;
}




Future _initWindow() async {
  if (!(Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    return;
  }
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(280, 280),
    center: true,
    title: "iYooT",
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}


void _initCoreLog() {
  //日志信息
  CoreLog.enableLog =
      !kReleaseMode || Pref.enableLog;
  CoreLog.requestLogType = RequestLogType.short;
  CoreLog.onPrintLog = (level, msg) {
    switch (level) {
      case Level.debug:
        Log.d(msg);
        break;
      case Level.error:
        Log.e(msg, StackTrace.current);
        break;
      case Level.info:
        Log.i(msg);
        break;
      case Level.warning:
        Log.w(msg);
        break;
      default:
        Log.logPrint(msg);
    }
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static ColorScheme? _light, _dark;

  static ThemeData? darkThemeData;

  static void _onBack() {
    if (SmartDialog.checkExist()) {
      SmartDialog.dismiss();
      return;
    }

    final route = Get.routing.route;
    if (route is GetPageRoute) {
      if (route.popDisposition == .doNotPop) {
        route.onPopInvokedWithResult(false, null);
        return;
      }
    }

    final navigator = Get.key.currentState;
    if (navigator?.canPop() ?? false) {
      navigator!.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamicColor = Pref.dynamicColor && _light != null && _dark != null;
    late final brandColor = colorThemeTypes[Pref.customColor].color;
    late final variant = Pref.schemeVariant;
    return GetMaterialApp(
      title: "iYooT",
      theme: ThemeUtils.getThemeData(
        colorScheme: dynamicColor
            ? _light!
            : brandColor.asColorSchemeSeed(variant, .light),
        isDynamic: dynamicColor,
      ),
      darkTheme: ThemeUtils.getThemeData(
        isDark: true,
        colorScheme: dynamicColor
            ? _dark!
            : brandColor.asColorSchemeSeed(variant, .dark),
        isDynamic: dynamicColor,
      ),
      themeMode:Pref.themeMode,
      initialRoute: RoutePath.kIndex,
      getPages: AppPages.routes,
      //国际化
      locale: const Locale("zh", "CN"),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("zh", "CN")],
      logWriterCallback: (text, {bool? isError}) {
        Log.addDebugLog(text, (isError ?? false) ? Colors.red : Colors.grey);
        Log.writeLog(text, (isError ?? false) ? Level.error : Level.info);
      },
      //debugShowCheckedModeBanner: false,
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(
        loadingBuilder: ((msg) => const AppLoaddingWidget()),
        //字体大小不跟随系统变化
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: Stack(
            children: [
              //侧键返回
              RawGestureDetector(
                excludeFromSemantics: true,
                gestures: <Type, GestureRecognizerFactory>{
                  FourthButtonTapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      FourthButtonTapGestureRecognizer>(
                        () => FourthButtonTapGestureRecognizer(),
                        (FourthButtonTapGestureRecognizer instance) {
                      instance.onTapDown = (TapDownDetails details) async {
                        //如果处于全屏状态，退出全屏
                        if (!Platform.isAndroid && !Platform.isIOS) {
                          if (await windowManager.isFullScreen()) {
                            await windowManager.setFullScreen(false);
                            return;
                          }
                        }
                        Get.back();
                      };
                    },
                  ),
                },
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (KeyEvent event) async {
                    if (event is KeyDownEvent &&
                        event.logicalKey == LogicalKeyboardKey.escape) {
                      // ESC退出全屏
                      // 如果处于全屏状态，退出全屏
                      if (!Platform.isAndroid && !Platform.isIOS) {
                        if (await windowManager.isFullScreen()) {
                          await windowManager.setFullScreen(false);
                          return;
                        }
                      }
                    }
                  },
                  child: child!,
                ),
              ),

              //查看DEBUG日志按钮
              //只在Debug、Profile模式显示
              Visibility(
                visible: !kReleaseMode,
                child: Positioned(
                  right: 12,
                  bottom: 100 + context.mediaQueryViewPadding.bottom,
                  child: Opacity(
                    opacity: 0.4,
                    child: ElevatedButton(
                      child: const Text("DEBUG LOG"),
                      onPressed: () {
                        Get.bottomSheet(
                          const DebugLogPage(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
