import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iyoot/pages/settings/models/model.dart';
import 'package:iyoot/utils/storage_key.dart';

List<SettingsModel> get videoSettings => [
   SwitchModel(
    title: '开启硬解',
    subtitle: '以较低功耗播放视频，若异常卡死请关闭',
    leading: Icon(Icons.flash_on_outlined),
    setKey: SettingBoxKey.enableHA,
    defaultVal: true,
  ),
];