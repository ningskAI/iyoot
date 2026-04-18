import 'package:freezed_annotation/freezed_annotation.dart';
part 'read_theme.freezed.dart';
part 'read_theme.g.dart';

@freezed
abstract class ReadTheme with _$ReadTheme {
  const factory ReadTheme({
    int? id,
    @Default('FFFBFBF3') backgroundColor,
    @Default('FF343434') textColor,
    @Default("") backgroundImagePath,
  }) = _ReadTheme;

  factory ReadTheme.fromJson(Map<String, dynamic> json) =>
      _$ReadThemeFromJson(json);
}
