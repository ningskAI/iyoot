import 'package:i_reader/core/constants/prefer_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static SharedPreferences? _prefs;
  static bool _initialized = false;
  static Future<void>? _initFuture;

  static bool get isInitialized => _initialized;

  /// 异步初始化（非阻塞）
  static Future<void> init() async {
    if (_initialized) return;
    await _ensureInitFuture();
  }

  /// 启动时预加载（不阻塞）
  static void preload() {
    _ensureInitFuture();
  }

  /// 等待预热完成，可选超时以避免启动阶段被无限阻塞。
  static Future<void> waitUntilReady({Duration? timeout}) async {
    final future = _ensureInitFuture();
    if (timeout == null) {
      await future;
      return;
    }

    await future.timeout(timeout, onTimeout: () {});
  }

  static Future<void> _ensureInitFuture() {
    if (_initialized) {
      return Future<void>.value();
    }

    final currentFuture = _initFuture;
    if (currentFuture != null) {
      return currentFuture;
    }

    final future = SharedPreferences.getInstance()
        .then((prefs) {
          _prefs = prefs;
          _initialized = true;
        })
        .catchError((error) {
          _initFuture = null;
          throw error;
        });

    _initFuture = future;
    return future;
  }

  // 获取字符串
  static String getString(String key, {String defaultValue = ''}) {
    if (!_initialized || _prefs == null) return defaultValue;
    return _prefs!.getString(key) ?? defaultValue;
  }

  // 设置字符串
  static Future<bool> setString(String key, String value) async {
    if (!_initialized || _prefs == null) {
      await init();
      if (_prefs == null) return false;
    }
    return _prefs!.setString(key, value);
  }

  // 获取整数
  static int getInt(String key, {int defaultValue = 0}) {
    if (!_initialized || _prefs == null) return defaultValue;
    return _prefs!.getInt(key) ?? defaultValue;
  }

  // 设置整数
  static Future<bool> setInt(String key, int value) async {
    if (!_initialized || _prefs == null) {
      await init();
      if (_prefs == null) return false;
    }
    return _prefs!.setInt(key, value);
  }

  // 获取布尔值
  static bool getBool(String key, {bool defaultValue = false}) {
    if (!_initialized || _prefs == null) return defaultValue;
    return _prefs!.getBool(key) ?? defaultValue;
  }

  // 设置布尔值
  static Future<bool> setBool(String key, bool value) async {
    if (!_initialized || _prefs == null) {
      await init();
      if (_prefs == null) return false;
    }
    return _prefs!.setBool(key, value);
  }

  // 获取双精度浮点数
  static double getDouble(String key, {double defaultValue = 0.0}) {
    if (!_initialized || _prefs == null) return defaultValue;
    return _prefs!.getDouble(key) ?? defaultValue;
  }

  // 设置双精度浮点数
  static Future<bool> setDouble(String key, double value) async {
    if (!_initialized || _prefs == null) {
      await init();
      if (_prefs == null) return false;
    }
    return _prefs!.setDouble(key, value);
  }

  // 删除
  static Future<bool> remove(String key) async {
    if (!_initialized || _prefs == null) return false;
    return _prefs!.remove(key);
  }

  // 清空
  static Future<bool> clear() async {
    if (!_initialized || _prefs == null) return false;
    return _prefs!.clear();
  }

  /// 记录堆转储
  static bool getRecordHeapDump() {
    return getBool(PreferKey.recordHeapDump, defaultValue: false);
  }

  static Future<bool> setRecordHeapDump(bool value) {
    return setBool(PreferKey.recordHeapDump, value);
  }

  /// 主题模式
  /// 0: 跟随系统, 1: 日间, 2: 夜间, 3: 电子墨水
  static int getThemeMode() {
    return getInt(PreferKey.themeMode, defaultValue: 2); // 2: Auto
  }

  static Future<bool> setThemeMode(int mode) {
    return setInt(PreferKey.themeMode, mode);
  }

  /// 是否电子墨水模式
  /// 参考项目：AppConfig.isEInkMode
  static bool isEInkMode() {
    return getThemeMode() == 3;
  }

  // ========== WebDAV 相关配置 ==========
  /// WebDAV 目录
  /// 参考项目：AppConfig.webDavDir
  static String getWebDavDir() {
    return getString(PreferKey.webDavDir, defaultValue: 'legado');
  }

  static Future<bool> setWebDavDir(String dir) {
    return setString(PreferKey.webDavDir, dir);
  }

  /// WebDAV 设备名
  /// 参考项目：AppConfig.webDavDeviceName
  static String getWebDavDeviceName() {
    // 注意：参考项目中使用 Build.MODEL 作为默认值，Flutter 中需要从平台获取
    return getString(PreferKey.webDavDeviceName, defaultValue: '');
  }

  static Future<bool> setWebDavDeviceName(String deviceName) {
    return setString(PreferKey.webDavDeviceName, deviceName);
  }

  /// WebDAV 自动同步
  static bool getWebDavAutoSync() {
    return getBool('webdav_auto_sync', defaultValue: false);
  }

  static Future<bool> setWebDavAutoSync(bool value) {
    return setBool('webdav_auto_sync', value);
  }

  /// WebDAV 启动时同步
  static bool getWebDavStartupSync() {
    return getBool('webdav_startup_sync', defaultValue: false);
  }

  static Future<bool> setWebDavStartupSync(bool value) {
    return setBool('webdav_startup_sync', value);
  }

  /// WebDAV 同步间隔（分钟）
  static int getWebDavSyncInterval() {
    return getInt(PreferKey.webDavSyncInterval, defaultValue: 30);
  }

  static Future<bool> setWebDavSyncInterval(int minutes) {
    return setInt(PreferKey.webDavSyncInterval, minutes);
  }

  /// WebDAV 冲突解决策略
  static String getWebDavConflictResolution() {
    return getString(
      PreferKey.webDavConflictResolution,
      defaultValue: 'keepNewer',
    );
  }

  static Future<bool> setWebDavConflictResolution(String strategy) {
    return setString(PreferKey.webDavConflictResolution, strategy);
  }

  // ========== 文件路径相关配置 ==========
  /// 备份路径
  /// 参考项目：AppConfig.backupPath
  static String? getBackupPath() {
    final path = getString(PreferKey.backupPath, defaultValue: '');
    return path.isEmpty ? null : path;
  }

  static Future<bool> setBackupPath(String? path) {
    if (path == null || path.isEmpty) {
      return remove(PreferKey.backupPath);
    }
    return setString(PreferKey.backupPath, path);
  }

  // =========== Web服务 ===========
  static int getLastServerPort() {
    final port = getInt(PreferKey.lastServerPort, defaultValue: 0);
    return port;
  }

  static Future<bool> setLastServerPort(int port) {
    return setInt(PreferKey.lastServerPort, port);
  }
}
