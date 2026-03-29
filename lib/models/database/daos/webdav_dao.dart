import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/webdav_configs.dart';

part 'webdav_dao.g.dart';

@DriftAccessor(tables: [WebDavConfigs])
class WebDavDao extends DatabaseAccessor<AppDatabase> with _$WebDavDaoMixin {
  WebDavDao(AppDatabase db) : super(db);

  Future<WebDavConfig?> getConfig() => (select(webDavConfigs)..limit(1)).getSingleOrNull();

  Future<void> updateConfig(WebDavConfigsCompanion companion) async {
    final existing = await getConfig();
    if (existing == null) {
      await into(webDavConfigs).insert(companion);
    } else {
      await (update(webDavConfigs)..where((t) => t.id.equals(existing.id))).write(companion);
    }
  }
}
