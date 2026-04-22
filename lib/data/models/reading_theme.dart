import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'reading_theme.freezed.dart';
part 'reading_theme.g.dart';

@freezed
abstract class ReadingTheme with _$ReadingTheme {
  const factory ReadingTheme({
    int? id,
    required String backgroundColor,
    required String textColor,
    required String backgroundImagePath,
  }) = _ReadingTheme;

  factory ReadingTheme.fromJson(Map<String, dynamic> json) =>
      _$ReadingThemeFromJson(json);
}

extension ReadingThemeExtension on ReadingTheme {
  Color get bgColor => Color(int.parse('0x$backgroundColor'));
  Color get textColorValue => Color(int.parse('0x$textColor'));
}
