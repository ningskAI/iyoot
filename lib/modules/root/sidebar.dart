import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iyoot/collections/side_bar_tiles.dart';
import 'package:iyoot/provider/ui_state_provider.dart';
class NextSidebar extends ConsumerWidget {
  const NextSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileList = getNavbarTileList(context);
    final selectedIndex = ref.watch(bottomTabIndexProvider);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child:SizedBox(
            width: 120,
            child: NavigationRail(
              leading: Container(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: SizedBox(
                  width: 36,
                  height: 36 ,
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
              labelType: NavigationRailLabelType.all,
              groupAlignment: 0,
              selectedIndex: selectedIndex,
              onDestinationSelected:(index) {
                // 更新状态
                ref.read(bottomTabIndexProvider.notifier).state = index;
                context.go(tileList[index].pathPrefix);
              },
              destinations: tileList.map((e) => NavigationRailDestination(
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