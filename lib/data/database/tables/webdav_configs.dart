import 'package:drift/drift.dart';

class WebDavConfigs extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// WebDAV 服务器地址
  TextColumn get url => text().withDefault(const Constant(""))();
  /// 账号
  TextColumn get username => text().withDefault(const Constant(""))();
  /// 密码 (加密存储)
  TextColumn get password => text().withDefault(const Constant(""))();
  /// 存放根目录
  TextColumn get rootPath => text().withDefault(const Constant("iyoot"))();

  /// 仅保留最新备份
  BoolColumn get keepLatestOnly => boolean().withDefault(const Constant(true))();
  /// 自动检查新备份
  BoolColumn get autoCheckNew => boolean().withDefault(const Constant(true))();

  /// 是否启用同步
  BoolColumn get isEnabled => boolean().withDefault(const Constant(false))();
  /// 上次同步时间
  DateTimeColumn get lastSyncTime => dateTime().nullable()();
}
