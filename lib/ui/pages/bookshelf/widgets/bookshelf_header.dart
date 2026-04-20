import 'package:flutter/material.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

/// 书架顶部header
class BookshelfHeader extends StatelessWidget {
  const BookshelfHeader({
    super.key,
    required this.onSearch,
    required this.onSync,
    required this.onMenuSelected,
  });

  final VoidCallback onSearch;
  final VoidCallback onSync;
  final Function(String) onMenuSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '书架',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HomePalette.primaryText(context),
                  ),
                ),
              ),
              HeaderActionButton(icon: Icons.search_rounded, onTap: onSearch),
              const SizedBox(width: 10),
              HeaderActionButton(icon: Icons.cloud_sync, onTap: onSync),
              const SizedBox(width: 10),
              _buildMenuButton(),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuButton<String> _buildMenuButton() {
    return PopupMenuButton<String>(
      padding: EdgeInsetsGeometry.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: PopupMenuPosition.under,
      onSelected: onMenuSelected,
      itemBuilder: (context) => [
        _buildMenuItem("add_local", Icons.add_box_outlined, "添加本地"),
        _buildMenuItem("add_remote", Icons.download_outlined, "添加远程"),
        _buildMenuItem("sort_book", Icons.sort_outlined, "书籍排序"),
      ],
      child: IgnorePointer(
        child: HeaderActionButton(icon: Icons.more_horiz_rounded, onTap: () {}),
      ),
    );
  }

  PopupMenuItem<String> _buildMenuItem(
    String value,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

/// 头部动作按钮
class HeaderActionButton extends StatelessWidget {
  const HeaderActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: HomePalette.mutedCard(context),
            shape: BoxShape.circle,
            border: Border.all(color: HomePalette.lineColor(context)),
          ),
          child: Icon(icon, size: 22, color: HomePalette.primaryText(context)),
        ),
      ),
    );
  }
}
