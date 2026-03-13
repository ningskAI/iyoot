import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/app/constant.dart';
import 'package:iyoot/app/event_bus.dart';
import 'package:iyoot/app/utils.dart';
import 'package:iyoot/models/home_page_item.dart';
import 'package:iyoot/pages//home/home_controller.dart';
import 'package:iyoot/pages/home/home_page.dart';
import 'package:iyoot/pages/live/live_controller.dart';
import 'package:iyoot/pages/live/live_page.dart';
import 'package:iyoot/pages/mine/mine_controller.dart';
import 'package:iyoot/pages/mine/mine_page.dart';
import 'package:iyoot/pages/music/view.dart';
import 'package:iyoot/pages/settings/view.dart';
import 'package:iyoot/utils/storage.dart';
import 'package:iyoot/utils/storage_key.dart';
import 'package:iyoot/utils/storage_pref.dart';

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
          Get.put(LiveController());
          pages[i] = const LivePage();
          break;
        case 2:
          pages[i] = const MusicPage();
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
    items.value = ['recommend','music','live', 'mine']
      .map((key) => Constant.allHomePages[key]!)
      .toList();
    setIndex(0);
    super.onInit();
  }

  void showFirstRun() async {
    if (Pref.isFirstRun) {
      GSStorage.setting.put(SettingBoxKey.isFirstRun, false);
      await Utils.showStatement();
    }
  }

}