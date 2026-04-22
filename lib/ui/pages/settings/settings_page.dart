import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/ui/widgets/td/td_appbar.dart';
import 'package:i_reader/ui/widgets/td/td_list_tile.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';
import 'package:remixicon/remixicon.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFFFFFFFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              TDAppbar(title: "设置"),
              const SizedBox(height: 12),
              Expanded(child: buildList(context, theme)),
            ],
          ),
        ),
      ),
    );
  }

  void toPage(BuildContext context, String? route) {
    if (route == null) return;
    context.pushNamed(route);
  }

  Widget buildList(BuildContext context, ThemeData theme) {
    final padding = MediaQuery.viewPaddingOf(context);
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: [
        // 阅读体验分区
        _buildSectionLabel(context, title: '阅读体验', subtitle: '外观主题、字体、阅读方式等'),
        const SizedBox(height: 10),
        _buildMenuSection(context, [
          _buildTile(
            context,
            icon: Icons.color_lens_outlined,
            iconColor: const Color(0xFF8B5CF6),
            title: L10n.of(context).settingsAppearance,
            subtitle: '横屏适配、侧栏、列宽、主题、字号等',
            route: "appearance",
          ),
          _buildTile(
            context,
            icon: Remix.book_read_line,
            iconColor: const Color(0xFF22C55E),
            title: L10n.of(context).settingsRead,
            subtitle: '字体、阅读样式、翻页方式等',
            route: "read",
          ),
        ]),
        const SizedBox(height: 20),

        // 数据管理分区
        _buildSectionLabel(context, title: '数据管理', subtitle: '备份恢复、缓存、文件管理'),
        const SizedBox(height: 10),
        _buildMenuSection(context, [
          _buildTile(
            context,
            icon: Icons.backup_outlined,
            iconColor: const Color(0xFFF59E0B),
            title: L10n.of(context).settingBackup,
            subtitle: 'WebDAV 与备份恢复',
            route: "backup",
          ),
          _buildTile(
            context,
            icon: Icons.storage_rounded,
            iconColor: const Color(0xFF06B6D4),
            title: '缓存管理',
            subtitle: '书籍缓存与空间占用',
            route: "cache",
          ),
          _buildTile(
            context,
            icon: Icons.folder_outlined,
            iconColor: const Color(0xFF1677FF),
            title: '文件管理',
            subtitle: '本地文件浏览与导入',
            route: "filemanager",
          ),
        ]),
        const SizedBox(height: 20),

        // 帮助与信息分区
        _buildSectionLabel(context, title: '帮助与信息', subtitle: '文档、实验功能、版本信息'),
        const SizedBox(height: 10),
        _buildMenuSection(context, [
          _buildTile(
            context,
            icon: Icons.help_outline_rounded,
            iconColor: const Color(0xFF06B6D4),
            title: '帮助',
            subtitle: '查看使用说明',
            route: "help",
          ),
          _buildTile(
            context,
            icon: Icons.link,
            iconColor: const Color(0xFF06B6D4),
            title: L10n.of(context).settingsInterface,
            subtitle: '实验室功能：源链接解析',
            route: null,
          ),
          _buildTile(
            context,
            icon: Icons.info_outline_rounded,
            iconColor: const Color(0xFF22C55E),
            title: '关于',
            subtitle: '版本与开源信息',
            trailing: const Text(
              'v2.2.0',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            route: "about",
          ),
        ]),
      ],
    );
  }

  Widget _buildSectionLabel(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: HomePalette.primaryText(context),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: HomePalette.tertiaryText(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: HomePalette.card(context).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: HomePalette.lineColor(context)),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: HomePalette.lineColor(context),
          indent: 50,
        ),
        itemBuilder: (_, index) => items[index],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? route,
    Widget? trailing,
  }) {
    return TDListTile(
      onTap: () => toPage(context, route),
      icon: icon,
      iconColor: iconColor,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
