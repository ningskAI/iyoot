// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'L10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '阅然';

  @override
  String get navbarRead => '阅读';

  @override
  String get navBarBookshelf => '书架';

  @override
  String get navBarLibrary => '书店';

  @override
  String get navBarStatistics => '分析';

  @override
  String get navBarNote => '笔记';

  @override
  String get navMine => '我的';

  @override
  String get navBarSettings => '设置';

  @override
  String get settingsAppearance => '外观设置';

  @override
  String get settingsRead => '阅读设置';

  @override
  String get settingsSync => '同步设置';

  @override
  String get settingsInterface => '接口设置';

  @override
  String get settingsTheme => '主题模式';

  @override
  String get settingsDarkMode => '深色模式';

  @override
  String get settingsLightMode => '浅色模式';

  @override
  String get settingsSystemMode => '系统模式';

  @override
  String get settingBackup => '备份与恢复';

  @override
  String get webDavSettings => 'WebDav 设置';

  @override
  String get webDavServerAddress => 'WebDav 服务器地址';

  @override
  String get webDavServerAddressHint => '输入你的服务器地址';

  @override
  String get webDavAccount => 'WebDav 账号';

  @override
  String get webDavAccountHint => '输入你的 WebDav 账号';

  @override
  String get webDavPassword => 'WebDav 密码';

  @override
  String get webDavPasswordHint => '输入你的 WebDav 授权密码';

  @override
  String get webDavSubFolder => '子文件夹';

  @override
  String get webDavDeviceName => '设备名称';

  @override
  String get syncReadingProgress => '同步阅读进度';

  @override
  String get syncReadingProgressSummary => '进入退出阅读界面时同步阅读进度';

  @override
  String get syncEnhancement => '同步增强';

  @override
  String get syncEnhancementSummary =>
      '重新进入页面（息屏、后台返回等）或者网络变为可用时同步云端进度，同步进度会询问';

  @override
  String get backupPath => '备份路径';

  @override
  String get backup => '备份';

  @override
  String get backupSummary => '本地和 WebDav 一起备份';

  @override
  String get restore => '恢复';

  @override
  String get restoreSummary => '优先从 WebDav 恢复，长按从本地恢复';

  @override
  String get restoreIgnoreList => '恢复忽略列表';

  @override
  String get restoreIgnoreListSummary => '恢复时忽略一些内容不恢复，方便不同手机配置不同';

  @override
  String get importOldData => '导入旧版数据';

  @override
  String get importOldDataSummary => '选择旧版备份文件文件夹';

  @override
  String get keepLatestBackupOnly => '仅保留最新备份';

  @override
  String get keepLatestBackupOnlySummary => '本地备份仅保留最新备份文件';

  @override
  String get autoCheckNewBackup => '自动检查新备份';

  @override
  String get autoCheckNewBackupSummary => '打开软件时检查是否有新备份，有新备份时提示是否更新';
}
