import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/app.dart';
import 'package:i_reader/services/logger/logger.dart';
import 'package:i_reader/services/startup/app_startup_coordinator.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await AppStartupCoordinator.initialize();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark, // For iOS status bar
    ),
  );

  runApp(
    ProviderScope(
      observers: const [AppLoggerProviderObserver()],
      child: App(), // 将预加载的数据传入
    ),
  );
}
