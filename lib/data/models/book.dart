import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:i_reader/utils/file_utils.dart';
part 'book.freezed.dart';
part 'book.g.dart';

@freezed
abstract class Book with _$Book {
  const factory Book({
    required int id,
    required String title,
    required String coverPath,
    required String filePath,
    required String lastReadPosition,
    required double readingPercentage,
    required String author,
    required int isDeleted,
    @Default("") String description,
    required double rating,
    required int groupId,
    @Default("") md5,
    required DateTime createTime,
    required DateTime updateTime,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

extension BookExtension on Book {
  String get coverFullPath => FileUtils.getBasePath(coverPath);
  String get fileFullPath => FileUtils.getBasePath(filePath);
}
