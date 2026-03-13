import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iyoot/models/common/enum_with_label.dart';
import 'package:iyoot/pages/anim/controller.dart';
import 'package:iyoot/pages/anim/view.dart';
import 'package:iyoot/pages/common/common_controller.dart';
import 'package:iyoot/pages/film/controller.dart';
import 'package:iyoot/pages/film/view.dart';
import 'package:iyoot/pages/recommend/controller.dart';
import 'package:iyoot/pages/recommend/view.dart';
import 'package:iyoot/pages/tv/controller.dart';
import 'package:iyoot/pages/tv/view.dart';
import 'package:iyoot/pages/variety/controller.dart';
import 'package:iyoot/pages/variety/view.dart';

enum HomeTabType implements EnumWithLabel {

  recommend("推荐"),
  tv("电视剧"),
  film("电影"),
  anim("动漫"),
  variety("综艺")
  ;


  @override
  final String label;

  const HomeTabType(this.label);

  ScrollOrRefreshMixin Function() get ctr => switch(this) {
    HomeTabType.recommend => Get.find<RecommendController>,
    HomeTabType.tv => Get.find<TVController>,
    HomeTabType.film => Get.find<FilmController>,
    HomeTabType.anim => Get.find<AnimController>,
    HomeTabType.variety => Get.find<VarietyController>
  };

  Widget get page => switch(this) {
    HomeTabType.recommend => const RecommendPage(),
    HomeTabType.tv => const TvPage(),
    HomeTabType.film => const FilmPage(),
    HomeTabType.anim => const AnimPage(),
    HomeTabType.variety => const VarietyPage()
  };



}