import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_group.freezed.dart';
part 'book_group.g.dart';

@freezed
abstract class BookGroup with _$BookGroup {
  const factory BookGroup({
    required int id,
    required String name,
    int? parentId,
    @Default(0) int isDeleted,
    required DateTime createTime,
    required DateTime updateTime,
  }) = _BookGroup;

  factory BookGroup.fromJson(Map<String, dynamic> json) =>
      _$BookGroupFromJson(json);
}
