import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iyoot/models/common/theme/theme_type.dart';
import 'package:iyoot/utils/storage.dart';
import 'package:iyoot/utils/storage_key.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart' show FlexSchemeVariant;

abstract final class Pref {
  static final Box _setting = GSStorage.setting;
  static final Box _localCache = GSStorage.localCache;

  static int get _themeTypeInt => _setting.get(
    SettingBoxKey.themeMode,
    defaultValue: ThemeType.system.index,
  );

  static ThemeType get themeType => ThemeType.values[_themeTypeInt];

  static ThemeMode get themeMode => switch (_themeTypeInt) {
    0 => ThemeMode.light,
    1 => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  static String? get downloadPath => _setting.get(SettingBoxKey.downloadPath);

  static bool get saveReply =>
      _setting.get(SettingBoxKey.saveReply, defaultValue: true);

  static bool get enableLog =>
      _setting.get(SettingBoxKey.enableLog, defaultValue: true);

  static int get appFontWeight =>
      _setting.get(SettingBoxKey.appFontWeight, defaultValue: -1);

  static bool get dynamicColor =>
      !Platform.isIOS &&
          _setting.get(SettingBoxKey.dynamicColor, defaultValue: true);

  static bool get isPureBlackTheme =>
      _setting.get(SettingBoxKey.isPureBlackTheme, defaultValue: false);

  static bool get darkVideoPage =>
      _setting.get(SettingBoxKey.darkVideoPage, defaultValue: false);

  static FlexSchemeVariant get schemeVariant =>
      FlexSchemeVariant.values[_setting.get(
        SettingBoxKey.schemeVariant,
        defaultValue: FlexSchemeVariant.material3Legacy.index,
      )];

  static int get customColor =>
      _setting.get(SettingBoxKey.customColor, defaultValue: 0);

  static bool get isFirstRun =>
      _setting.get(SettingBoxKey.isFirstRun, defaultValue: true);
}