import 'package:get/get.dart';
import 'package:iyoot/app/constant.dart';
import 'package:iyoot/services/local_storage_service.dart';

class AppSettingsController extends GetxController{

  static AppSettingsController get instance =>
      Get.find<AppSettingsController>();

  /// 缩放模式
  var scaleMode = 0.obs;
  var themeMode = 0.obs;
  var firstRun = false;

  @override
  void onInit() {
    firstRun = LocalStorageService.instance
        .getValue(LocalStorageService.kFirstRun, true);
    isDynamic.value = LocalStorageService.instance
      .getValue(LocalStorageService.kIsDynamic, false);
    styleColor.value = LocalStorageService.instance
      .getValue(LocalStorageService.kStyleColor, 0xff3498db);
    initSiteSort();
    initHomeSort();
    super.onInit();
  }

  void initSiteSort() {

  }

  void initHomeSort() {
    var sort = LocalStorageService.instance
        .getValue(
      LocalStorageService.kHomeSort,
      Constant.allHomePages.keys.join(","),
    )
        .split(",");
    //如果数量与allSites的数量不一致，将缺失的添加上
    if (sort.length != Constant.allHomePages.length) {
      var keys = Constant.allHomePages.keys.toList();
      for (var i = 0; i < keys.length; i++) {
        if (!sort.contains(keys[i])) {
          sort.add(keys[i]);
        }
      }
    }

    homeSort.value = sort;
  }

  var styleColor = 0xff3498db.obs;
  void setStyleColor(int e) {
    styleColor.value = e;
    LocalStorageService.instance.setValue(LocalStorageService.kStyleColor, e);
  }


  var isDynamic = false.obs;
  void setIsDynamic(bool e) {
    isDynamic.value = e;
    LocalStorageService.instance.setValue(LocalStorageService.kIsDynamic, e);
  }

  RxList<String> homeSort = RxList<String>();
  void setHomeSort(List<String> e) {
    homeSort.value = e;
    LocalStorageService.instance.setValue(
      LocalStorageService.kHomeSort,
      homeSort.join(","),
    );
  }

  void setNoFirstRun() {
    LocalStorageService.instance.setValue(LocalStorageService.kFirstRun, false);
  }

  var logEnable = false.obs;
  void setLogEnable(bool e) {
    logEnable.value = e;
    LocalStorageService.instance.setValue(LocalStorageService.kLogEnable, e);
  }


}