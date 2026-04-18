import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/reading_time.dart';

abstract class ReadingTimeDatasource extends BaseDatasource {
  Future<void> insertReadingTime(
    ReadingTime readingTime, {
    DateTime? startedAt,
  });
  Future<void> insertReadingSession({
    required int bookId,
    required int readingTime,
    DateTime? startedAt,
  });
  Future<List<ReadingTime>> selectAllReadingTime();
  Future<int> selectTotalReadingTime();
  Future<int> selectTotalNumberOfBook();
}
