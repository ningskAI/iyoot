import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/ui/widgets/td/td_themed_bottom_nav.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/side_bar_tile.dart';
import 'package:i_reader/providers/ui_state_provider.dart';

class NextNavigationBar extends ConsumerWidget {
  final Axis orientation;

  const NextNavigationBar({super.key, this.orientation = Axis.horizontal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = getNavbarTileList(context);
    final selectedIndex = ref.watch(bottomTabIndexProvider);

    if (orientation == Axis.vertical) {
      // Pad 模式：竖向侧边栏
      return Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tileList.length,
                itemBuilder: (context, index) {
                  final item = tileList[index];
                  final isSelected = selectedIndex == index;
                  return _buildVerticalNavItem(
                    context,
                    item: item,
                    index: index,
                    isSelected: isSelected,
                    onTap: () {
                      ref.read(bottomTabIndexProvider.notifier).state = index;
                      context.go(item.pathPrefix);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    } else {
      // 手机模式：底部导航栏
      return TDThemedBottomNavBar(
        height: 60,
        currentIndex: selectedIndex,
        onChanged: (index) {
          ref.read(bottomTabIndexProvider.notifier).state = index;
          context.go(tileList[index].pathPrefix);
        },
        items: tileList
            .map(
              (item) => TDThemedNavItem(
                icon: item.icon,
                selectedIcon: item.selectedIcon,
                label: item.title,
              ),
            )
            .toList(),
      );
    }
  }

  Widget _buildVerticalNavItem(
    BuildContext context, {
    required SideBarTile item,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: item.title,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Icon(
                isSelected ? item.selectedIcon : item.icon,
                size: 28,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
