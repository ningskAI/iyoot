import 'package:i_reader/data/database/app_database.dart';
import 'package:i_reader/data/datasources/book_note_datasource.dart';
import 'package:i_reader/data/models/book_note.dart';

class BookNoteDatasourceImpl extends BookNoteDatasource {
  static const List<String> annotationTypes = [
    'underline',
    'bookmark',
    'highlight',
  ];

  static String get _typeFilter =>
      "type IN ('${annotationTypes.join("', '")}')";

  @override
  Future<int> save(BookNote bookNote) async {
    final json = bookNote.toJson();
    if (bookNote.id != null && bookNote.id! > 0) {
      // Update existing
      await updateBookNoteById(bookNote);
      return bookNote.id!;
    } else {
      // Insert new
      json.remove('id');
      return insert('tb_notes', json);
    }
  }

  @override
  Future<List<BookNote>> selectBookNoteByCfiAndBookId(
    String cfi,
    int bookId,
  ) async {
    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: 'cfi = ? AND bookId = ?',
      whereArgs: [cfi, bookId],
    );
  }

  @override
  Future<List<BookNote>> selectBookNotesByBookId(int bookId) async {
    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: 'bookId = ? AND $_typeFilter',
      whereArgs: [bookId],
      orderBy: 'chapter,cfi',
    );
  }

  /// Select notes by bookId with optional hasNote filter
  @override
  Future<List<BookNote>> selectBookNotesByBookIdWithNote(
    int bookId,
    bool hasNote,
  ) async {
    String where = 'bookId = ? AND $_typeFilter';
    List<dynamic> args = [bookId];

    if (hasNote) {
      where += ' AND readerNote IS NOT NULL AND readerNote != ""';
    } else {
      where += ' AND (readerNote IS NULL OR readerNote = "")';
    }

    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: where,
      whereArgs: args,
      orderBy: 'chapter,cfi',
    );
  }

  @override
  Future<void> updateBookNoteById(BookNote bookNote) async {
    await update(
      'tb_notes',
      bookNote.toJson(),
      where: 'id = ?',
      whereArgs: [bookNote.id],
    );
  }

  @override
  Future<BookNote> selectBookNoteById(int id) async {
    final note = await querySingle(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (note == null) {
      throw StateError('BookNote with id $id not found');
    }
    return note;
  }

  @override
  Future<List<Map<String, int>>> selectAllBookIdAndNotes() async {
    final database = await AppDatabase.instance.database;
    if (database == null) throw StateError("database has not inited");

    final result = await database.rawQuery(
      'SELECT bookId, COUNT(*) as count FROM tb_notes WHERE $_typeFilter GROUP BY bookId',
    );

    return result
        .map(
          (row) => {
            'bookId': row['bookId'] as int,
            'count': row['count'] as int,
          },
        )
        .toList();
  }

  @override
  Future<Map<String, int>> selectNumberOfNotesAndBooks() async {
    final database = await AppDatabase.instance.database;
    if (database == null) throw StateError("database has not inited");

    final noteCountResult = await database.rawQuery(
      'SELECT COUNT(*) as count FROM tb_notes',
    );
    final noteCount = noteCountResult.first['count'] as int? ?? 0;

    final bookCountResult = await database.rawQuery(
      'SELECT COUNT(DISTINCT bookId) as count FROM tb_notes',
    );
    final bookCount = bookCountResult.first['count'] as int? ?? 0;

    return {'notes': noteCount, 'books': bookCount};
  }

  @override
  Future<void> deleteBookNoteById(int id) async {
    await delete('tb_notes', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<BookNote>> searchBookNotes(String keyword) async {
    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: '$_typeFilter AND (content LIKE ? OR readerNote LIKE ?)',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'updateTime DESC',
    );
  }

  @override
  Future<List<BookNote>> searchBookNotesAdvanced({
    String? keyword,
    int? bookId,
    DateTime? from,
    DateTime? to,
    int? limit,
    List<String>? types,
  }) async {
    String where = _typeFilter;
    List<Object?> whereArgs = [];

    if (keyword != null && keyword.isNotEmpty) {
      where += ' AND (content LIKE ? OR readerNote LIKE ?)';
      whereArgs.addAll(['%$keyword%', '%$keyword%']);
    }

    if (bookId != null) {
      where += ' AND bookId = ?';
      whereArgs.add(bookId);
    }

    if (from != null) {
      where += ' AND createTime >= ?';
      whereArgs.add(from.toIso8601String());
    }

    if (to != null) {
      where += ' AND createTime <= ?';
      whereArgs.add(to.toIso8601String());
    }

    if (types != null && types.isNotEmpty) {
      where += " AND type IN ('${types.join("', '")}')";
    }

    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: where,
      whereArgs: whereArgs,
      orderBy: 'updateTime DESC',
      limit: limit,
    );
  }

  @override
  Future<BookNote?> selectRandomNote() async {
    final database = await AppDatabase.instance.database;
    if (database == null) throw StateError("database has not inited");

    final result = await database.rawQuery(
      'SELECT * FROM tb_notes WHERE $_typeFilter ORDER BY RANDOM() LIMIT 1',
    );

    if (result.isEmpty) return null;
    return BookNote.fromJson(result.first);
  }
}
