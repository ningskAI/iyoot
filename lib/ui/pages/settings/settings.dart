import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/setting_tile.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/ui/widgets/d_list_tile.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';
import 'package:i_reader/ui/widgets/view_safe_area.dart';
import 'package:remixicon/remixicon.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return HomePageBackground(
      glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(L10n.of(context).navBarSettings)),
        body: ViewSafeArea(child: buildList(context, theme)),
      ),
    );
  }

  void toPage(BuildContext context, String? route) {
    if (route == null) return;
    context.pushNamed(route);
  }

  Widget buildList(BuildContext context, ThemeData theme) {
    final padding = MediaQuery.viewPaddingOf(context);
    final items = getSettingTiles(context);
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: items
          .take(items.length)
          .map(
            (item) => DListTile(
              onTap: () => toPage(context, item.route),
              icon: item.icon,
              iconColor: item.iconColor,
              title: item.title,
              subtitle: item.subtitle,
              trailing: item.trailing,
            ),
          )
          .toList(),
    );
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
      title: L10n.of(context).settingBackup,
      subtitle: 'WebDAV 与备份恢复',
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
}
