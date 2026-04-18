import 'package:flutter/material.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:remixicon/remixicon.dart';

class SettingTile {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final String? route;
  final Widget? trailing;

  const SettingTile({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.route,
    this.trailing,
  });
}

List<SettingTile> getSettingTiles(BuildContext context) => [
  SettingTile(
    title: L10n.of(context).settingsAppearance,
    subtitle: '横屏适配（平板）、侧栏、列宽、主题、字号、图片、帧率等',
    icon: Icons.color_lens_outlined,
    iconColor: const Color(0xFF8B5CF6),
    route: "appearance",
  ),
  SettingTile(
    title: L10n.of(context).settingsRead,
    subtitle: '阅读、字体、样式等',
    iconColor: const Color(0xFF22C55E),
    icon: Remix.book_read_line,
  ),
  SettingTile(
    title: L10n.of(context).settingsSync,
    subtitle: 'Webdav配置',
    icon: Icons.sync,
    iconColor: const Color(0xFFEC4899),
    route: "webdav",
  ),
  SettingTile(
    title: L10n.of(context).settingBackup,
    subtitle: '备份与重置',
    icon: Icons.backup_outlined,
    route: "backup",
    iconColor: const Color(0xFFF59E0B),
  ),
  SettingTile(
    icon: Icons.storage_rounded,
    iconColor: const Color(0xFF06B6D4),
    title: '缓存管理',
    subtitle: '管理书籍缓存与空间占用',
    route: "cache",
  ),
  SettingTile(
    icon: Icons.folder_outlined,
    iconColor: const Color(0xFF1677FF),
    title: '文件管理',
    subtitle: '浏览本地文件与导入目录',
    route: "filemanager",
  ),
  SettingTile(
    icon: Icons.help_outline_rounded,
    iconColor: const Color(0xFF06B6D4),
    title: '帮助',
    subtitle: '查看使用说明',
    route: "help",
  ),
  SettingTile(
    title: L10n.of(context).settingsInterface,
    subtitle: '实验室功能：源链接解析',
    icon: Icons.link,
    iconColor: const Color(0xFF06B6D4),
  ),
  SettingTile(
    icon: Icons.info_outline_rounded,
    iconColor: const Color(0xFF22C55E),
    title: '关于',
    trailing: Text(
      'v2.2.0',
      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
    ),
    route: "about",
  ),
];
