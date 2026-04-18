import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_style.freezed.dart';
part 'book_style.g.dart';

@freezed
abstract class BookStyle with _$BookStyle {
  const factory BookStyle({
    required double fontSize,
    required String fontFamily,
    required int fontWeight,
    required double lineHeight,
    required double letterSpacing,
    required double wordSpacing,
    required double paragraphSpacing,
    required double sideMargin,
    required double topMargin,
    required double bottomMargin,
    required double indent,
    required int maxColumnCount,
    required double headingFontSize,
    required double columnThreshold,
  }) = _BookStyle;

  factory BookStyle.fromJson(Map<String, dynamic> json) =>
      _$BookStyleFromJson(json);
}
