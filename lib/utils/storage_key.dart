abstract final class SettingBoxKey {
  /// 首次运行
  static const String isFirstRun = 'firstRun';

  /// 是否显示日志
  static const enableLog = "enableLog";

  /// 主题模式
  static const themeMode = "themeMode";

  /// 是否支持关键词搜索
  static const enableSearchWord = "enableSearchWord";

  /// 下载路径
  static const downloadPath = 'downloadPath';

  static const saveReply = 'saveReply';
  static const appFontWeight = 'appFontWeight';
  static const dynamicColor = 'dynamicColor';
  static const isPureBlackTheme = 'isPureBlackTheme';
  static const darkVideoPage = 'darkVideoPage';
  static const customColor = 'customColor';
  static const schemeVariant = 'schemeVariant';
  static const badCertificateCallback = 'badCertificateCallback';
  static const refreshDisplacement = 'refreshDisplacement';
  static const defaultToastOp = 'defaultToastOp';
  static const enableHA = 'enableHA';
  static const autoPlayEnable = 'autoPlayEnable';
  static const enableQuickDouble = 'enableQuickDouble';
  static const enableShowDanmaku = 'enableShowDanmaku';
  static const autoClearCache = 'autoClearCache';
  static const maxCacheSize = 'maxCacheSize';
}



abstract final class LocalCacheKey {
  static const String historyPause = 'historyPause',
      blackMids = 'blackMids',
      danmakuFilterRules = 'danmakuFilterRules',
      mixinKey = 'mixinKey',
      timeStamp = 'timeStamp',
      buvid = 'buvid';
}

abstract final class VideoBoxKey {
  static const String playRepeat = 'playRepeat',
      playSpeedDefault = 'playSpeedDefault',
      longPressSpeedDefault = 'longPressSpeedDefault',
      speedsList = 'speedsList',
      cacheVideoFit = 'cacheVideoFit';
}