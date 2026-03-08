import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/app/constant.dart';
import 'package:iyoot/app/controller/app_settings_controller.dart';
import 'package:iyoot/app/event_bus.dart';
import 'package:iyoot/app/utils.dart';
import 'package:iyoot/models/home_page_item.dart';
import 'package:iyoot/modules/duanju/duanju_controller.dart';
import 'package:iyoot/modules/duanju/duanju_page.dart';
import 'package:iyoot/modules/home/home_controller.dart';
import 'package:iyoot/modules/home/home_page.dart';
import 'package:iyoot/modules/live/live_controller.dart';
import 'package:iyoot/modules/live/live_page.dart';
import 'package:iyoot/modules/mine/mine_controller.dart';
import 'package:iyoot/modules/mine/mine_page.dart';

class IndexedController extends GetxController{

  RxList<HomePageItem> items = RxList<HomePageItem>([]);

  var index = 0.obs;
  RxList<Widget> pages = RxList<Widget>([
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox()
  ]);

  void setIndex(int i) {
    if (pages[i] is SizedBox) {
      switch(items[i].index) {
        case 0:
          Get.put(HomeController());
          pages[i] = const HomePage();
          break;
        case 1:
          Get.put(DuanjuController());
          pages[i] = const DuanjuPage();
          break;
        case 2:
          Get.put(LiveController());
          pages[i] = const LivePage();
          break;
        case 3:
          Get.put(MineController());
          pages[i] = const MinePage();
          break;
        default:
      }
    } else {
      if (index.value == i) {
        EventBus.instance
            .emit<int>(EventBus.kBottomNavigationBarClicked, items[i].index);
      }
    }
    index.value = i;
  }

  @override
  void onInit() {
    Future.delayed(Duration.zero, showFirstRun);
    items.value = AppSettingsController.instance.homeSort
      .map((key) => Constant.allHomePages[key]!)
      .toList();
    setIndex(0);
    super.onInit();
  }

  void showFirstRun() async {
    var settingsController = Get.find<AppSettingsController>();
    if (settingsController.firstRun) {
      settingsController.setNoFirstRun();
      await Utils.showStatement();
    }
  }

}