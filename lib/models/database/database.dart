import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart'; // 主文件的生成文件

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

@DriftDatabase(tables: [
  PreferencesTable,
])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    final cacheBase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase.createInBackground(file);
  });
}

