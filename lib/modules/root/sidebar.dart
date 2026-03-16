import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/side_bar_tiles.dart';
import 'package:auto_route/auto_route.dart';
class NextSidebar extends HookConsumerWidget {
  const NextSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = getSideBarTileList();
    final router = context.watchRouter;
    final selectedIndex = max(
      0,
      tileList.indexWhere(
            (e) => router.currentPath.startsWith(e.pathPrefix),
      ),
    );
    return SizedBox(
      width: 130,
      child: NavigationRail(
        groupAlignment: 0,
        selectedIndex: selectedIndex,
        onDestinationSelected:(index) {
          final tile = tileList[index];
          context.navigateTo(tile.route);
        },
        labelType: NavigationRailLabelType.all,
        destinations: tileList.map((e) => NavigationRailDestination(
            icon: Icon(e.icon),
            label: Text(e.title),
            selectedIcon: Icon(e.selectedIcon)
        )).toList(),
      ),
    );
  }
}