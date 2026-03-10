import 'package:iyoot/models/common/enum_with_label.dart';

enum HomeTabType implements EnumWithLabel {

  tv("电视剧"),
  film("电影"),
  anim("动漫"),
  variety("综艺")
  ;


  @override
  final String label;

  const HomeTabType(this.label);
}