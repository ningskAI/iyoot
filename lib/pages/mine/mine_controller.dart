import 'package:get/get.dart';
import 'package:iyoot/models/common/theme/theme_type.dart';
import 'package:iyoot/utils/storage_pref.dart';

class MineController extends GetxController{
  Rx<ThemeType> themeType = Pref.themeType.obs;
}