import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/models/common/home_tab_type.dart';
import 'package:iyoot/pages/common/common_controller.dart';

class HomeController extends GetxController
  with GetSingleTickerProviderStateMixin, ScrollOrRefreshMixin{

  late List<HomeTabType> tabs;
  late TabController tabController;

  RxBool? showTopBar;
  late final bool hideTopBar;


  @override
  Future<void> onRefresh() {
    // TODO: implement onRefresh
    throw UnimplementedError();
  }

  @override
  // TODO: implement scrollController
  ScrollController get scrollController => throw UnimplementedError();

}