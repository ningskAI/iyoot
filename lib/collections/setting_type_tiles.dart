import 'package:flutter/material.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:remixicon/remixicon.dart';

class SettingTile {
  final String title;
  final String? subtitle;
  final Icon icon;
  final String? route;

  const SettingTile({
    required this.title,
    this.subtitle,
    required this.icon,
    this.route
  });
}

List<SettingTile> getSettingTiles(BuildContext context) => [
  SettingTile(
    title: L10n.of(context).settingsAppearance,
    subtitle: '横屏适配（平板）、侧栏、列宽、主题、字号、图片、帧率等',
    icon: Icon(Icons.style_outlined),
    route: "appearance"
  ),
  SettingTile(
    title: L10n.of(context).settingsRead,
    subtitle: '阅读、字体、样式等',
    icon: Icon(Remix.book_read_line),
  ),
  SettingTile(
    title: L10n.of(context).settingsSync,
    subtitle: 'WebDav、导入、导出',
    icon: Icon(Icons.sync),
    route: "backup"
  ),
  SettingTile(
    title: L10n.of(context).settingsInterface,
    subtitle: '实验室功能：源链接解析',
    icon: Icon(Icons.link),
  ),
];