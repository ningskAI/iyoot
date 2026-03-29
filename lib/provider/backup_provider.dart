import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/database/database.dart';
import 'database.dart';

part 'backup_provider.g.dart';

@riverpod
class WebDavConfigNotifier extends _$WebDavConfigNotifier {
  @override
  Future<WebDavConfig?> build() async {
    final db = ref.watch(databaseProvider);
    return db.webDavDao.getConfig();
  }

  Future<void> updateConfig({
    String? url,
    String? username,
    String? password,
    String? rootPath,
    bool? keepLatestOnly,
    bool? autoCheckNew,
  }) async {
    final db = ref.read(databaseProvider);

    final companion = WebDavConfigsCompanion(
      url: url != null ? Value(url) : const Value.absent(),
      username: username != null ? Value(username) : const Value.absent(),
      password: password != null ? Value(password) : const Value.absent(),
      rootPath: rootPath != null ? Value(rootPath) : const Value.absent(),
      keepLatestOnly: keepLatestOnly != null ? Value(keepLatestOnly) : const Value.absent(),
      autoCheckNew: autoCheckNew != null ? Value(autoCheckNew) : const Value.absent(),
    );

    await db.webDavDao.updateConfig(companion);
    ref.invalidateSelf();
  }
}
