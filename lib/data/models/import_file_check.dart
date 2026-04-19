import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:i_reader/data/models/book.dart';
part 'import_file_check.freezed.dart';
part 'import_file_check.g.dart';

@freezed
abstract class ImportFileCheck with _$ImportFileCheck {
  const factory ImportFileCheck({
    required String filePath,
    String? md5,
    required bool isDuplicate,
    Book? duplicateBook,
    required bool isRestore,
    Book? restoreBook,
  }) = _ImportFileCheck;

  factory ImportFileCheck.fromJson(Map<String, dynamic> json) =>
      _$ImportFileCheckFromJson(json);
}
