import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/book_extra.dart';
import 'package:i_reader/data/models/book_note.dart';

abstract class BookNoteDatasource extends BaseDatasource {
  Future<int> save(BookNote bookNote);
  Future<List<BookNote>> selectBookNoteByCfiAndBookId(String cfi, int bookId);
  Future<List<BookNote>> selectBookNotesByBookId(int bookId);
  Future<List<BookNote>> selectBookNotesByBookIdWithNote(
    int bookId,
    bool hasNote,
  );
  Future<void> updateBookNoteById(BookNote bookNote);
  Future<BookNote> selectBookNoteById(int id);
  Future<List<Map<String, int>>> selectAllBookIdAndNotes();
  Future<Map<String, int>> selectNumberOfNotesAndBooks();
  Future<void> deleteBookNoteById(int id);
  Future<List<BookNote>> searchBookNotes(String keyword);
  Future<List<BookNote>> searchBookNotesAdvanced({
    String? keyword,
    int? bookId,
    DateTime? from,
    DateTime? to,
    int? limit,
    List<String>? types,
  });
  Future<BookNote?> selectRandomNote();
  Future<List<BookExtra>> getBookExtraList();
}
