import 'package:i_reader/data/database/app_database.dart';
import 'package:i_reader/data/datasources/reading_time_datasource.dart';
import 'package:i_reader/data/models/reading_time.dart';

class ReadingTimeDatasourceImpl extends ReadingTimeDatasource {
  @override
  Future<void> insertReadingSession({
    required int bookId,
    required int readingTime,
    DateTime? startedAt,
  }) async {
    final session = ReadingTime(
      bookId: bookId,
      readingTime: readingTime,
      date: startedAt?.toIso8601String(),
    );

    await insertReadingTime(session, startedAt: startedAt);
  }

  @override
  Future<void> insertReadingTime(
    ReadingTime readingTime, {
    DateTime? startedAt,
  }) async {
    final db = await AppDatabase.instance.database;
    if (db == null) throw StateError("database has not inited");
    final resolvedDay = _resolveDayString(readingTime, startedAt);

    final insertReadingTime = readingTime.copyWith(date: resolvedDay);

    await db.transaction((txn) async {
      final existing = await txn.rawQuery(
        'SELECT id, readingTime FROM tb_reading_time WHERE bookId = ? AND DATE(date) = DATE(?) LIMIT 1',
        [insertReadingTime.bookId, resolvedDay],
      );

      if (existing.isNotEmpty) {
        final current = existing.first['readingTime'] as int? ?? 0;
        await txn.update(
          'tb_reading_time',
          {
            'readingTime': current + insertReadingTime.readingTime,
            // keep legacy date value unchanged to avoid churn
          },
          where: 'id = ?',
          whereArgs: [existing.first['id']],
        );
      } else {
        await txn.insert('tb_reading_time', {
          'bookId': insertReadingTime.bookId,
          'date': resolvedDay,
          'readingTime': insertReadingTime.readingTime,
        });
      }
    });
  }

  @override
  Future<List<ReadingTime>> selectAllReadingTime() async {
    return queryList(
      'tb_reading_time',
      mapper: ReadingTime.fromJson,
      orderBy: 'datetime(date) DESC, id DESC',
    );
  }

  @override
  Future<int> selectTotalNumberOfBook() async {
    final result = await rawQuerySingle(
      'SELECT COUNT(DISTINCT bookId) AS totalCount FROM tb_reading_time',
      mapper: (row) => row['totalCount'] as int? ?? 0,
    );
    return result ?? 0;
  }

  @override
  Future<int> selectTotalReadingTime() async {
    final result = await rawQuerySingle(
      'SELECT SUM(reading_time) AS total_sum FROM tb_reading_time',
      mapper: (row) => row['total_sum'] as int? ?? 0,
    );
    return result ?? 0;
  }

  String _resolveDayString(ReadingTime readingTime, DateTime? startedAt) {
    final fromModel = readingTime.startedAt;
    if (fromModel != null) {
      return _dayKey(fromModel);
    }

    if (startedAt != null) {
      return _dayKey(startedAt);
    }

    final raw = readingTime.date;
    if (raw != null && raw.length >= 10) {
      return raw.substring(0, 10);
    }

    return _dayKey(DateTime.now());
  }

  String _dayKey(DateTime dateTime) =>
      dateTime.toIso8601String().substring(0, 10);
}
