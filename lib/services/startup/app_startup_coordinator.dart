import 'package:flutter/material.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:i_reader/utils/startup_performance_monitor.dart';

typedef _StartupAction = Future<void> Function();

class _StartupTask {
  const _StartupTask({
    required this.stage,
    required this.errorMessage,
    required this.action,
  });

  final String stage;
  final String errorMessage;
  final _StartupAction action;
}

class AppStartupCoordinator {
  AppStartupCoordinator._();

  static Future<void> initialize() async {
    startupPerformanceMonitor.reset();
    startupPerformanceMonitor.start('total_app_startup');
    WidgetsFlutterBinding.ensureInitialized();
    startupPerformanceMonitor.end('widget_binding');
    try {
      await startupPerformanceMonitor.trackAsync('app_config_init', () async {
        AppConfig.preload();
        await Future.wait([
          AppConfig.waitUntilReady(timeout: const Duration(milliseconds: 400)),
        ]);
      });

      startupPerformanceMonitor.end('total_app_startup');
      if (AppLog.enableStartupLogs) {
        AppLog.instance.putStartup(
          '应用初始化完成，总耗时: ${startupPerformanceMonitor.getDuration('total_app_startup')?.inMilliseconds ?? 0}ms',
        );
        startupPerformanceMonitor.printAllDurations();
      }
    } catch (ex) {
      AppLog.instance.put('应用初始化过程中发生未预期的错误', error: ex);
    }
  }
}
