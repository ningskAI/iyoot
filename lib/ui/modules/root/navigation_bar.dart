import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/ui/widgets/td/td_themed_bottom_nav.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/side_bar_tiles.dart';
import 'package:i_reader/providers/ui_state_provider.dart';

class NextNavigationBar extends ConsumerWidget {
  const NextNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = getNavbarTileList(context);
    final selectedIndex = ref.watch(bottomTabIndexProvider);
    return TDThemedBottomNavBar(
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
