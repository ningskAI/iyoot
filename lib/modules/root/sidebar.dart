import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/side_bar_tiles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:iyoot/provider/ui_state_provider.dart';
class NextSidebar extends HookConsumerWidget {
  const NextSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = getNavbarTileList(context);
    final selectedIndex = ref.watch(bottomTabIndexProvider);
    return Column(
      children: [
        const SizedBox(height: 25),
        const Spacer(flex: 2),
        Expanded(
          flex: 5,
          child:SizedBox(
            width: 130,
            child: NavigationDrawer(
              backgroundColor: Colors.transparent,
              tilePadding: const EdgeInsetsGeometry.symmetric(
                vertical: 5,
                horizontal: 12,
              ),
              indicatorShape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
              ),
              selectedIndex: selectedIndex,
              onDestinationSelected:(index) {
                // 更新状态
                ref.read(bottomTabIndexProvider.notifier).state = index;
                context.go(tileList[index].pathPrefix);
              },
              children: tileList.map((e) => NavigationDrawerDestination(
                  icon: Icon(e.icon, size: 21,),
                  label: Text(e.title),
                  selectedIcon: Icon(e.selectedIcon, size: 21,)
              )).toList(),
            ),
          ) ,
        )
      ],
    );
  }
}