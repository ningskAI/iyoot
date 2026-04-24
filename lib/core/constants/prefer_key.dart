class PreferKey {
  PreferKey._();

  /// 主题模式
  static const String themeMode = 'themeMode';

  /// 记录堆转储
  static const String recordHeapDump = 'recordHeapDump';

  // ========== WebDAV ==========
  /// WebDAV URL
  static const String webDavUrl = 'web_dav_url';

  /// WebDAV 账号
  static const String webDavAccount = 'web_dav_account';

  /// WebDAV 密码
  static const String webDavPassword = 'web_dav_password';

  /// WebDAV 目录
  static const String webDavDir = 'webDavDir';

  /// WebDAV 设备名
  static const String webDavDeviceName = 'webDavDeviceName';

  /// 远程服务器 ID
  static const String remoteServerId = 'remoteServerId';

  /// WebDAV 自动同步
  static const String webDavAutoSync = 'webDavAutoSync';

  /// WebDAV 启动时同步
  static const String webDavStartupSync = 'webDavStartupSync';

  /// WebDAV 同步间隔（分钟）
  static const String webDavSyncInterval = 'webDavSyncInterval';

  /// WebDAV 冲突解决策略
  static const String webDavConflictResolution = 'webDavConflictResolution';

  // ========== 备份和恢复 ==========
  /// 备份路径
  static const String backupPath = 'backupUri';

  /// 恢复忽略
  static const String restoreIgnore = 'restoreIgnore';

  /// 仅最新备份
  static const String onlyLatestBackup = 'onlyLatestBackup';

  /// 自动检查新备份
  static const String autoCheckNewBackup = 'autoCheckNewBackup';

  // ========== Web服务 ==============
  static const String lastServerPort = 'lastServerPort';
  static const String recordLog = 'recordLog';

  // ========= 阅读主题相关设置 ==========
  static const String awakeTime = 'awakeTime';
  static const String pageTurningType = 'pageTurningType';
  static const String bookStyle = 'bookStyle';
}
