import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:iyoot/common/widgets/custom_toast.dart';
import 'package:iyoot/models/common/theme/theme_type.dart';
import 'package:iyoot/pages/mine/mine_controller.dart';
import 'package:iyoot/pages/settings/models/model.dart';
import 'package:iyoot/pages/settings/widgets/slider_dialog.dart';
import 'package:iyoot/utils/storage.dart';
import 'package:iyoot/utils/storage_key.dart';
import 'package:iyoot/utils/storage_pref.dart';
import 'package:path/path.dart' as path;
import 'package:iyoot/pages/settings/widgets/select_dialog.dart';
import 'package:iyoot/common/widgets/color_palette.dart';



List<SettingsModel> get styleSettings => [
  NormalModel(
    leading: const Icon(Icons.opacity_outlined),
    title: '气泡提示不透明度',
    subtitle: '自定义气泡提示(Toast)不透明度',
    getTrailing: (theme) => Text(
      CustomToast.toastOpacity.toStringAsFixed(1),
      style: theme.textTheme.titleSmall,
    ),
    onTap: _showToastDialog,
  ),
  NormalModel(
    onTap: _showThemeTypeDialog,
    leading: const Icon(Icons.flashlight_on_outlined),
    title: '主题模式',
    getSubtitle: () => '当前模式：${Pref.themeType.desc}',
  ),
  SwitchModel(
    leading: const Icon(Icons.invert_colors),
    title: '纯黑主题',
    setKey: SettingBoxKey.isPureBlackTheme,
    defaultVal: false,
    onChanged: (value) {
      if (Get.isDarkMode || Pref.darkVideoPage) {
        Get.forceAppUpdate();
      }
    },
  ),

];

Future<void> _showToastDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<double>(
    context: context,
    builder: (context) => SliderDialog(
      title: 'Toast不透明度',
      value: CustomToast.toastOpacity,
      min: 0.0,
      max: 1.0,
      divisions: 10,
    ),
  );
  if (res != null) {
    CustomToast.toastOpacity = res;
    await GSStorage.setting.put(SettingBoxKey.defaultToastOp, res);
    SmartDialog.showToast('设置成功');
    setState();
  }
}

Future<void> _showThemeTypeDialog(
  BuildContext context,
  VoidCallback setState,
) async {
  final res = await showDialog<ThemeType>(
    context: context,
    builder: (context) => SelectDialog<ThemeType>(
      title: '主题模式',
      value: Pref.themeType,
      values: ThemeType.values.map((e) => (e, e.desc)).toList(),
    ),
  );
  if (res != null) {
    try {
      Get.find<MineController>().themeType.value = res;
    } catch (_) {}
    GSStorage.setting.put(SettingBoxKey.themeMode, res.index);
    Get.changeThemeMode(res.toThemeMode);
    setState();
  }
}


