import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/core/database/database.dart';
import 'package:i_reader/core/database/tables/preferences.dart';
import 'package:i_reader/provider/database.dart';
import 'package:i_reader/services/logger/logger.dart';
import 'package:i_reader/utils/platform.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:flutter/material.dart' hide join;

typedef UserPreferences = PreferencesTableData;

class UserPreferencesNotifier extends Notifier<PreferencesTableData> {
  @override
  PreferencesTableData build() {
    final defaultConfig = PreferencesTableData(
      id: 0,
      isFirstRun: true,
      themeMode: ThemeMode.system,
      locale: const Locale("system", "system"),
      isDarkMode: false,
      cacheMusic: true,
      downloadLocation: "",
      defaultToastOp: 1.0,
      enableAutoPlay: true,
      enableOpenHA: true,
      layoutMode: LayoutMode.auto,
    );
    // 异步放在同步build里内部执行;
    _init();
    return defaultConfig;
  }

  Future<void> _init() async {
    final db = ref.read(databaseProvider);
    // 读取配置
    final config = await (db.select(
      db.preferencesTable,
    )..where((tbl) => tbl.id.equals(0))).getSingleOrNull();
    if (config == null) {
      await db
          .into(db.preferencesTable)
          .insert(
            PreferencesTableCompanion.insert(
              id: const Value(0),
              downloadLocation: Value(await _getDefaultDownloadDirectory()),
            ),
          );
    }

    // 监听变化并更新state
    state = await (db.select(
      db.preferencesTable,
    )..where((tbl) => tbl.id.equals(0))).getSingle();

    final subscription =
        (db.select(db.preferencesTable)..where((tbl) => tbl.id.equals(0)))
            .watchSingle()
            .listen((event) async {
              try {
                state = event;
              } catch (e, stack) {
                AppLogger.reportError(e, stack);
              }
            });

    ref.onDispose(() {
      subscription.cancel();
    });
  }

  Future<String> _getDefaultDownloadDirectory() async {
    if (kIsAndroid) return "/storage/emulated/0/Download/iyoot";

    if (kIsMacOS) {
      return join((await paths.getLibraryDirectory()).path, "Caches");
    }

    return paths.getDownloadsDirectory().then((dir) {
      return join(dir!.path, "iyoot");
    });
  }

  Future<void> setData(PreferencesTableCompanion data) async {
    final db = ref.read(databaseProvider);

    final query = db.update(db.preferencesTable)..where((t) => t.id.equals(0));

    await query.write(data);
  }

  void setLayoutMode(LayoutMode mode) {
    setData(PreferencesTableCompanion(layoutMode: Value(mode)));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await setData(PreferencesTableCompanion(themeMode: Value(mode)));
  }
}

final userPreferencesProvider =
    NotifierProvider<UserPreferencesNotifier, PreferencesTableData>(
      () => UserPreferencesNotifier(),
    );
