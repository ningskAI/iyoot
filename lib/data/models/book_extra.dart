import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:i_reader/utils/file_utils.dart';

part 'book_extra.freezed.dart';
part 'book_extra.g.dart';

@freezed
abstract class BookExtra with _$BookExtra {
  const factory BookExtra({
    required int bookId,
    required String title,
    required String coverPath,
    required String filePath,
    required String author,
    required int numberOfNotes,
    required int readingTime,
    required double readingPercentage,
  }) = _BookExtra;

  factory BookExtra.fromJson(Map<String, dynamic> json) =>
      _$BookExtraFromJson(json);
}

extension BookExtraExtension on BookExtra {
  String get coverFullPath => FileUtils.getBasePath(coverPath);
  String get fileFullPath => FileUtils.getBasePath(filePath);
}
