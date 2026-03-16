part of '../database.dart';

enum LayoutMode {
  auto, /// 支持横竖屏
  sidebar, /// 仅支持侧边栏
  bottomBar /// 仅支持底边栏
}

class PreferencesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  /// 是否首次启动
  BoolColumn get isFirstRun => boolean().withDefault(const Constant(true))();
  /// 主题模式
  TextColumn get themeMode =>
      textEnum<ThemeMode>().withDefault(Constant(ThemeMode.system.name))();
  /// 是否黑夜模式
  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();
  /// 缓存音乐
  BoolColumn get cacheMusic => boolean().withDefault(const Constant(true))();
  /// 下载路径
  TextColumn get downloadLocation => text().withDefault(const Constant(""))();
  /// 默认吐司参数
  RealColumn get defaultToastOp => real().withDefault(const Constant(1.0))();
  /// 自动播放 默认不允许
  BoolColumn get enableAutoPlay => boolean().withDefault(const Constant(false))();
  /// 是否开启硬件加速
  BoolColumn get enableOpenHA => boolean().withDefault(const Constant(false))();
  /// 首页布局模式
  TextColumn get layoutMode => textEnum<LayoutMode>().withDefault(Constant(LayoutMode.auto.name))();
}