import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

enum SettingType {
  styleSetting("外观设置"),
  readSetting("阅读设置"),
  syncSetting("同步设置"),
  interfaceSetting("接口配置"),
  ;

  final String title;

  const SettingType(this.title);

}
class SettingTile {
  final SettingType type;
  final String? subtitle;
  final Icon icon;

  const SettingTile({
    required this.type,
    this.subtitle,
    required this.icon,
  });
}

List<SettingTile> getSettingTiles() => [
  SettingTile(
    type: SettingType.styleSetting,
    subtitle: '横屏适配（平板）、侧栏、列宽、主题、字号、图片、帧率等',
    icon: Icon(Icons.style_outlined),
  ),
  SettingTile(
    type: SettingType.readSetting,
    subtitle: '阅读、字体、样式等',
    icon: Icon(Remix.book_read_line),
  ),
  SettingTile(
    type: SettingType.syncSetting,
    subtitle: 'WebDav、导入、导出',
    icon: Icon(Icons.sync),
  ),
  SettingTile(
    type: SettingType.interfaceSetting,
    subtitle: '实验室功能：源链接解析',
    icon: Icon(Icons.link),
  ),
];