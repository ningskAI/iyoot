import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/providers/repository_providers.dart';

final bookmarkProvider = NotifierProvider<BookmarkNotifier, List<BookNote>>(
  () => BookmarkNotifier(),
);

class BookmarkNotifier extends Notifier<List<BookNote>> {
  @override
  List<BookNote> build() {
    return [];
  }

  Future<void> loadBookmarks(int bookId) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    final notes = await repository.selectBookNotesByBookId(bookId);
    state = notes.where((note) => note.type == 'bookmark').toList();
  }

  Future<BookNote> addBookmark(BookNote note) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    note.type = 'bookmark';
    final id = await repository.save(note);
    final savedNote = note..id = id;
    state = [...state, savedNote];
    return savedNote;
  }

  Future<void> removeBookmark({int? id, String? cfi}) async {
    if (id == null && cfi == null) {
      // 没有足够的信息来删除书签
      return;
    }
    try {
      if (id == null) {
        final bookmark = state.firstWhere((b) => b.cfi == cfi);
        id = bookmark.id;
      }

      if (cfi == null) {
        final bookmark = state.firstWhere((b) => b.id == id);
        cfi = bookmark.cfi;
      }

      final repository = ref.read(bookNoteRepositoryProvider);
      await repository.deleteBookNoteById(id!);
    } catch (e) {
      // 如果在当前状态中找不到对应的书签，直接返回
      return;
    }
  }
}
