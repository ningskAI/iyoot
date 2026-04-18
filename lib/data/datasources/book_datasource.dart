import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/book.dart';

abstract class BookDatasource extends BaseDatasource {
  Future<int> save(Book book);
  Future<int> insertBook(Book book);
  Future<void> updateBook(Book book);
  Future<List<Book>> selectBooks({bool includeDeleted = true});
  Future<List<Book>> selectNotDeleteBooks();
  Future<Book> selectBookById(int id);
  Future<List<String>> getCurrentBooks();
  Future<List<String>> getCurrentCover();
  Future<Book?> getBookByMd5(String md5);
  Future<void> updateBookMd5(int bookId, String md5);
  Future<List<Book>> getBooksWithoutMd5();
}
