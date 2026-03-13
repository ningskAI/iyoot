import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/models/common/home_tab_type.dart';
import 'package:iyoot/utils/storage.dart';
import 'package:iyoot/utils/storage_key.dart';
import 'package:iyoot/utils/storage_pref.dart';
class HomeController extends GetxController
  with GetSingleTickerProviderStateMixin{

  late List<HomeTabType> tabs;
  late TabController tabController;

  RxBool? showTopBar;
  late final bool hideTopBar;

  bool enableSearchWord = Pref.enableSearchWord;

  late final RxString defaultSearch = ''.obs;
  late int lateCheckSearchAt = 0;

  @override
  void onInit() {
    setTabConfig();
    super.onInit();
  }

  void setTabConfig() {
    final tabs = GSStorage.setting.get(SettingBoxKey.tabBarSort) as List?;
    if (tabs != null) {
      this.tabs = tabs.map((i) => HomeTabType.values[i]).toList();
    } else {
      this.tabs = HomeTabType.values;
    }

    tabController = TabController(
      initialIndex: max(0, this.tabs.indexOf(HomeTabType.recommend)),
      length: this.tabs.length,
      vsync: this,
    );
  }




  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

}