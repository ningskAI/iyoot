import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_note.freezed.dart';
part 'book_note.g.dart';

@freezed
abstract class BookNote with _$BookNote {
  const factory BookNote({
    int? id,
    required int bookId,
    required String content,
    required String cfi,
    required String chapter,
    required String type,
    required String color,
    String? readerNote,
    required DateTime createTime,
    required DateTime updateTime,
  }) = _BookNote;

  factory BookNote.fromJson(Map<String, dynamic> json) =>
      _$BookNoteFromJson(json);
}
