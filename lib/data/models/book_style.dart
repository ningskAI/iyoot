import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_style.freezed.dart';
part 'book_style.g.dart';

@freezed
abstract class BookStyle with _$BookStyle {
  const factory BookStyle({
    @Default(1.4) required double fontSize,
    @Default("Arial") required String fontFamily,
    @Default(400) required int fontWeight,
    @Default(1.8) required double lineHeight,
    @Default(0.0) required double letterSpacing,
    @Default(0.0) required double wordSpacing,
    @Default(1.0) required double paragraphSpacing,
    @Default(6.0) required double sideMargin,
    @Default(90.0) required double topMargin,
    @Default(50.0) required double bottomMargin,
    @Default(0) required double indent,
    @Default(0) required int maxColumnCount,
    @Default(1.0) required double headingFontSize,
    @Default(720.0) required double columnThreshold,
  }) = _BookStyle;

  factory BookStyle.fromJson(Map<String, dynamic> json) =>
      _$BookStyleFromJson(json);
}
