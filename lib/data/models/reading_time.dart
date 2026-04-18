import 'package:freezed_annotation/freezed_annotation.dart';

part 'reading_time.freezed.dart';
part 'reading_time.g.dart';

@freezed
abstract class ReadingTime with _$ReadingTime {
  const factory ReadingTime({
    int? id,
    required int bookId,
    String? date,
    required int readingTime,
  }) = _ReadingTime;

  factory ReadingTime.fromJson(Map<String, dynamic> json) =>
      _$ReadingTimeFromJson(json);
}

extension ReadingTimeExt on ReadingTime {
  DateTime? get startedAt {
    final raw = date;
    if (raw == null || raw.isEmpty) {
      return null;
    }

    DateTime? tryParse(String value) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return null;
      }
    }

    return tryParse(raw) ?? tryParse(raw.replaceFirst(' ', 'T'));
  }

  /// Extracts only the calendar day portion (YYYY-MM-DD) when available.
  String? get dateOnly {
    final parsed = startedAt;
    if (parsed != null) {
      return parsed.toIso8601String().substring(0, 10);
    }

    final raw = date;
    if (raw == null || raw.length < 10) {
      return null;
    }
    return raw.substring(0, 10);
  }
}
