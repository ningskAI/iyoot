import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:i_reader/data/enums/reading_info.dart';
part 'reading_info.freezed.dart';
part 'reading_info.g.dart';

@freezed
abstract class ReadingInfoSectionModel with _$ReadingInfoSectionModel {
  const factory ReadingInfoSectionModel({
    @Default(ReadingInfoEnum.chapterTitle) ReadingInfoEnum left,
    @Default(ReadingInfoEnum.none) ReadingInfoEnum center,
    @Default(ReadingInfoEnum.none) ReadingInfoEnum right,
    @Default(20) double verticalMargin,
    @Default(20) double leftMargin,
    @Default(20) double rightMargin,
    @Default(12) double fontSize,
  }) = _ReadingInfoSectionModel;

  factory ReadingInfoSectionModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingInfoSectionModelFromJson(json);
}

@freezed
abstract class ReadingInfoModel with _$ReadingInfoModel {
  const factory ReadingInfoModel({
    @Default(
      ReadingInfoSectionModel(
        left: ReadingInfoEnum.chapterTitle,
        verticalMargin: 40,
        fontSize: 12,
      ),
    )
    ReadingInfoSectionModel header,
    @Default(
      ReadingInfoSectionModel(
        left: ReadingInfoEnum.batteryAndTime,
        center: ReadingInfoEnum.chapterProgress,
        right: ReadingInfoEnum.bookProgress,
        verticalMargin: 20,
      ),
    )
    ReadingInfoSectionModel footer,
  }) = _ReadingInfoModel;

  factory ReadingInfoModel.fromJson(Map<String, dynamic> json) =>
      _$ReadingInfoModelFromJson(json);
}
