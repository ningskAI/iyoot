import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:ui'; // 增加：为 Locale 提供支持
import 'package:flutter/material.dart' show ThemeMode; // 增加：为 ThemeMode 提供支持
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

// 引入表文件
import 'tables/preferences.dart';
import 'tables/clc_categories.dart';
import 'tables/volumes.dart';
import 'tables/reading.dart';
import 'tables/gems.dart';
import 'tables/webdav_configs.dart';

// 引入 DAO
import 'daos/webdav_dao.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    PreferencesTable,
    ClcCategories,
    Volumes,
    VolumeLocations,
    Fragments,
    ReadingProgress,
    Gems,
    WebDavConfigs,
  ],
  daos: [
    WebDavDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // 预置中图法22大类数据
        final categories = {
          'A': '马克思主义、列宁主义、毛泽东思想、邓小平理论',
          'B': '哲学、宗教',
          'C': '社会科学总论',
          'D': '政治、法律',
          'E': '军事',
          'F': '经济',
          'G': '文化、科学、教育、体育',
          'H': '语言、文字',
          'I': '文学',
          'J': '艺术',
          'K': '历史、地理',
          'N': '自然科学总论',
          'O': '数理科学和化学',
          'P': '天文学、地球科学',
          'Q': '生物科学',
          'R': '医药、卫生',
          'S': '农业科学',
          'T': '工业技术',
          'U': '交通运输',
          'V': '航空、航天',
          'X': '环境科学、安全科学',
          'Z': '综合性图书',
        };

        for (final entry in categories.entries) {
          await into(clcCategories).insert(
            ClcCategoriesCompanion.insert(
              code: entry.key,
              name: entry.value,
            ),
          );
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationSupportDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }
    sqlite3.tempDirectory = (await getTemporaryDirectory()).path;
    return NativeDatabase.createInBackground(file);
  });
}
