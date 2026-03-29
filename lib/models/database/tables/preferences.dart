import 'dart:convert';
import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

enum LayoutMode { auto, sidebar, bottomBar }

class LocaleConverter extends TypeConverter<Locale, String> {
  const LocaleConverter();
  @override
  Locale fromSql(String fromDb) {
    final rawMap = jsonDecode(fromDb) as Map<String, dynamic>;
    return Locale(rawMap["languageCode"] ?? 'en', rawMap["countryCode"]);
  }
  @override
  String toSql(Locale value) {
    return jsonEncode({
      "languageCode": value.languageCode,
      "countryCode": value.countryCode,
    });
  }
}

class PreferencesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isFirstRun => boolean().withDefault(const Constant(true))();
  TextColumn get themeMode => textEnum<ThemeMode>().withDefault(Constant(ThemeMode.system.name))();
  TextColumn get locale => text()
      .withDefault(const Constant('{"languageCode":"system","countryCode":"system"}'))
      .map(const LocaleConverter())();
  BoolColumn get isDarkMode => boolean().withDefault(const Constant(false))();
  BoolColumn get cacheMusic => boolean().withDefault(const Constant(true))();
  TextColumn get downloadLocation => text().withDefault(const Constant(""))();
  RealColumn get defaultToastOp => real().withDefault(const Constant(1.0))();
  BoolColumn get enableAutoPlay => boolean().withDefault(const Constant(false))();
  BoolColumn get enableOpenHA => boolean().withDefault(const Constant(false))();
  TextColumn get layoutMode => textEnum<LayoutMode>().withDefault(Constant(LayoutMode.auto.name))();
}
