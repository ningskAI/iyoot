import 'package:i_reader/data/datasources/book_note_datasource.dart';
import 'package:i_reader/data/models/book_note.dart';

class BookNoteDatasourceImpl extends BookNoteDatasource {
  static const List<String> annotationTypes = [
    'highlight',
    'underline',
    'bookmark',
  ];

  static String get _typeFilter =>
      "type IN ('${annotationTypes.join("', '")}')";

  @override
  Future<void> deleteBookNoteById(int id) async {
    await delete('tb_notes', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> save(BookNote bookNote) async {
    if (bookNote.id != null) {
      await updateBookNoteById(bookNote);
      return bookNote.id!;
    }

    final duplicates = await selectBookNoteByCfiAndBookId(
      bookNote.cfi,
      bookNote.bookId,
    );
    if (duplicates.isNotEmpty) {
      await updateBookNoteById(bookNote.copyWith(id: duplicates.last.id));
      return bookNote.id!;
    }
    return insert("tb_notes", bookNote.toJson());
  }

  @override
  Future<void> updateBookNoteById(BookNote bookNote) async {
    await update(
      "tb_notes",
      bookNote.toJson(),
      where: 'id = ?',
      whereArgs: [bookNote.id],
    );
  }

  @override
  Future<List<BookNote>> searchBookNotes(String keyword) async {
    final query = keyword.trim();
    if (query.isEmpty) {
      return Future.value(const []);
    }
    return searchBookNotesAdvanced(keyword: query, types: annotationTypes);
  }

  @override
  Future<List<BookNote>> searchBookNotesAdvanced({
    String? keyword,
    int? bookId,
    DateTime? from,
    DateTime? to,
    int? limit,
    List<String>? types,
  }) {
    final where = <String>[];
    final whereArgs = <Object?>[];
    final query = keyword?.trim();

    // Filter by types (defaults to annotation types if not specified)
    final filterTypes = types ?? annotationTypes;
    if (filterTypes.isNotEmpty) {
      where.add("type IN ('${filterTypes.join("', '")}')");
    }

    if (query != null && query.isNotEmpty) {
      where.add('(content LIKE ? OR reader_note LIKE ? OR chapter LIKE ?)');
      final pattern = '%$query%';
      whereArgs.addAll([pattern, pattern, pattern]);
    }

    if (bookId != null) {
      where.add('book_id = ?');
      whereArgs.add(bookId);
    }

    if (from != null) {
      where.add('update_time >= ?');
      whereArgs.add(from.toIso8601String());
    }

    if (to != null) {
      where.add('update_time <= ?');
      whereArgs.add(to.toIso8601String());
    }

    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'update_time DESC',
      limit: limit,
    );
  }

  @override
  Future<List<Map<String, int>>> selectAllBookIdAndNotes() async {
    return rawQueryList(
      'SELECT book_id, COUNT(id) AS number_of_notes FROM tb_notes WHERE $_typeFilter GROUP BY book_id ORDER BY number_of_notes DESC',
      mapper: (row) => <String, int>{
        'bookId': row['book_id'] as int? ?? 0,
        'numberOfNotes': row['number_of_notes'] as int? ?? 0,
      },
    ).then((rows) => rows.where((element) => element['bookId'] != 0).toList());
  }

  @override
  Future<List<BookNote>> selectBookNoteByCfiAndBookId(
    String cfi,
    int bookId,
  ) async {
    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: 'cfi = ? AND book_id = ? AND $_typeFilter',
      whereArgs: [cfi, bookId],
      orderBy: 'update_time ASC',
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
      throw StateError('Book note with id $id not found');
    }

    return note;
  }

  @override
  Future<List<BookNote>> selectBookNotesByBookId(int bookId) async {
    return queryList(
      'tb_notes',
      mapper: BookNote.fromJson,
      where: 'book_id = ? AND $_typeFilter',
      whereArgs: [bookId],
      orderBy: 'update_time DESC',
    );
  }

  @override
  Future<Map<String, int>> selectNumberOfNotesAndBooks() async {
    final result = await rawQuerySingle(
      'SELECT COUNT(id) AS number_of_notes, COUNT(DISTINCT book_id) AS number_of_books FROM tb_notes WHERE $_typeFilter',
      mapper: (row) => <String, int>{
        'numberOfNotes': row['number_of_notes'] as int? ?? 0,
        'numberOfBooks': row['number_of_books'] as int? ?? 0,
      },
    );

    return result ?? const {'numberOfNotes': 0, 'numberOfBooks': 0};
  }

  @override
  Future<BookNote?> selectRandomNote() async {
    return rawQuerySingle(
      'SELECT * FROM tb_notes WHERE $_typeFilter ORDER BY RANDOM() LIMIT 1',
      mapper: BookNote.fromJson,
    );
  }
}
