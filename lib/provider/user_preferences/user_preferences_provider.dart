import 'package:drift/drift.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/models/database/database.dart';
import 'package:iyoot/provider/database/database.dart';
import 'package:iyoot/services/logger/logger.dart';
import 'package:iyoot/utils/platform.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:shadcn_flutter/shadcn_flutter.dart' hide join;

typedef UserPreferences = PreferencesTableData;

class UserPreferencesNotifier extends Notifier<PreferencesTableData> {
  @override
  PreferencesTableData build() {
    final db = ref.watch(databaseProvider);

    (db.select(db.preferencesTable)..where((tbl) => tbl.id.equals(0)))
        .getSingleOrNull()
        .then((result) async {
      if (result == null) {
        await db.into(db.preferencesTable).insert(
          PreferencesTableCompanion.insert(
            id: const Value(0),
            downloadLocation: Value(await _getDefaultDownloadDirectory()),
          ),
        );
      }

      state = await (db.select(db.preferencesTable)
        ..where((tbl) => tbl.id.equals(0)))
          .getSingle();

      final subscription = (db.select(db.preferencesTable)
        ..where((tbl) => tbl.id.equals(0)))
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
    });
    return PreferencesTableData(
        id: 0,
        isFirstRun: true,
        themeMode: ThemeMode.system,
        isDarkMode: false,
        cacheMusic: true,
        downloadLocation: "",
        defaultToastOp: 1.0,
        enableAutoPlay: false,
        enableOpenHA: false,
    );
  }

  Future<String> _getDefaultDownloadDirectory() async {
    if (kIsAndroid) return "/storage/emulated/0/Download/iYooT";

    if (kIsMacOS) {
      return join((await paths.getLibraryDirectory()).path, "Caches");
    }

    return paths.getDownloadsDirectory().then((dir) {
      return join(dir!.path, "iYooT");
    });
  }
}

final userPreferencesProvider =
  NotifierProvider<UserPreferencesNotifier, PreferencesTableData>(
      () => UserPreferencesNotifier(),
);
