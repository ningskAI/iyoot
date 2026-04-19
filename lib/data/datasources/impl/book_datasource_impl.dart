import 'package:i_reader/data/datasources/book_datasource.dart';
import 'package:i_reader/data/models/book.dart';

class BookDatasourceImpl extends BookDatasource {
  @override
  Future<Book?> getBookByMd5(String md5) async {
    return querySingle(
      'tb_books',
      mapper: Book.fromJson,
      where: 'fileMd5 = ?',
      whereArgs: [md5],
    );
  }

  @override
  Future<List<String>> getCurrentBooks() async {
    final books = await selectNotDeleteBooks();
    return books.map((book) => book.filePath).toList(growable: false);
  }

  @override
  Future<List<String>> getCurrentCover() async {
    final books = await selectNotDeleteBooks();
    return books.map((book) => book.coverPath).toList(growable: false);
  }

  @override
  Future<int> insertBook(Book book) {
    return save(book);
  }

  @override
  Future<int> save(Book book) async {
    if (book.id != -1) {
      await updateBook(book);
      return book.id;
    }
    return insert('tb_books', book.toJson());
  }

  @override
  Future<Book> selectBookById(int id) async {
    final book = await querySingle(
      'tb_notes',
      mapper: Book.fromJson,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (book == null) {
      throw StateError('Book with id $id not found');
    }
    return book;
  }

  @override
  Future<List<Book>> selectBooks({bool includeDeleted = true}) {
    return queryList(
      'tb_books',
      mapper: Book.fromJson,
      where: includeDeleted ? null : 'isDeleted = 0',
      orderBy: 'updateTime DESC',
    );
  }

  @override
  Future<List<Book>> selectNotDeleteBooks() {
    return selectBooks(includeDeleted: false);
  }

  @override
  Future<void> updateBook(Book book) async {
    await update(
      'tb_books',
      book.copyWith(updateTime: DateTime.now()).toJson(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  @override
  Future<List<Book>> getBooksWithoutMd5() async {
    return queryList(
      'tb_books',
      mapper: Book.fromJson,
      where: "isDeleted = 0 AND (fileMd5 IS NULL OR fileMd5 = '')",
      orderBy: 'updateTime DESC',
    );
  }

  @override
  Future<void> updateBookMd5(int bookId, String md5) async {
    await update(
      'tb_books',
      {'fileMd5': md5, 'updateTime': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [bookId],
    );
  }
}
