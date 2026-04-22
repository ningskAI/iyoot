import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_bookmark.freezed.dart';
part 'book_bookmark.g.dart';

@freezed
abstract class BookBookmark with _$BookBookmark {
  const factory BookBookmark({
    int? id,
    required int bookId,
    required String cfi,
    required double percentage,
    required String content,
    required String chapter,
    required DateTime createTime,
    required DateTime updateTime,
  }) = _BookBookmark;

  factory BookBookmark.fromJson(Map<String, dynamic> json) =>
      _$BookBookmarkFromJson(json);
}
