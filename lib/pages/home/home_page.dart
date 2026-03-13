import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/app/app_style.dart';
import 'package:iyoot/common/widgets/scroll_physics.dart';
import 'package:iyoot/pages/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 8,
        title: TabBar(
          controller: controller.tabController,
          labelPadding: AppStyle.edgeInsetsH20,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          tabAlignment: TabAlignment.center,
          dividerHeight: 1,
          dividerColor: Colors.transparent,
          tabs: controller.tabs
              .map(
                (e) => Tab(text: e.label),
          ).toList(),
        ),
      ),
      body:  Expanded(
        child:  tabBarView(
          controller: controller.tabController,
          children: controller.tabs.map((e) => e.page).toList(),
        ),
      ),
    );
  }
}
