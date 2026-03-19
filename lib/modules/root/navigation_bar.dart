import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/side_bar_tiles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:iyoot/provider/ui_state_provider.dart';
class NextNavigationBar extends HookConsumerWidget {
  const NextNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = useMemoized(() => getNavbarTileList(context));
    final selectedIndex = ref.watch(bottomTabIndexProvider);
    return NavigationBar(
        selectedIndex: selectedIndex,
        height: 56,
        onDestinationSelected:(index) {
          ref.read(bottomTabIndexProvider.notifier).state = index;
          context.go(tileList[index].pathPrefix);
        },
        destinations: tileList.map(
            (item) => NavigationDestination(
                icon: Icon(item.icon, size: 21,),
                selectedIcon: Icon(item.selectedIcon, size: 21,),
                label: item.title)
            )
            .toList()
    );
  }

}