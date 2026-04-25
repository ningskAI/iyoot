import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booknote_provider.g.dart';

@Riverpod(keepAlive: true)
class BookNoteNotifier extends _$BookNoteNotifier {
  int? _bookId;
  List<String>? _types;

  @override
  Future<List<BookNote>> build(int bookId) async {
    _bookId = bookId;
    return _fetchNotes(bookId, types: _types);
  }

  Future<List<BookNote>> _fetchNotes(int bookId, {List<String>? types}) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    // Assuming repository has a method to fetch by types, or we filter locally if not.
    // If repository.selectBookNotesByBookId doesn't support types, we might need to fetch all and filter locally,
    // or update the repository interface. For now, assuming we can pass types or filter locally.
    // Let's assume we fetch all and filter locally for simplicity if DB query isn't updated,
    // OR ideally, the repository supports it.
    // Looking at file2, it used datasource.searchBookNotesAdvanced.
    // Let's assume repository exposes similar capability or we adapt.
    // If repository.selectBookNotesByBookId does NOT take types, we must filter locally.

    final notes = await repository.selectBookNotesByBookId(bookId);

    if (types != null && types.isNotEmpty) {
      return notes.where((note) => types.contains(note.type)).toList();
    }

    return notes;
  }

  void refreshNotes() {
    ref.invalidateSelf();
  }

  Future<void> loadNotes({List<String>? types}) async {
    if (_bookId == null) return;
    _types = types;
    final notes = await _fetchNotes(_bookId!, types: types);
    state = AsyncData(notes);
  }

  // Add filter methods
  void filterByTypes(List<String> types) {
    loadNotes(types: types);
  }

  void resetFilter() {
    loadNotes(types: null);
  }

  Future<BookNote> addNote(BookNote note) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    final id = await repository.save(note);
    final savedNote = note..id = id;

    // Reload to ensure consistency and ordering
    await loadNotes(types: _types);

    return savedNote;
  }

  Future<void> removeNote({int? id, String? cfi}) async {
    if (id == null && cfi == null) return;

    try {
      final bookmarks = state.valueOrNull ?? [];
      final targetIndex = bookmarks.indexWhere((b) {
        if (id != null && b.id == id) return true;
        if (cfi != null && b.cfi == cfi) return true;
        return false;
      });

      if (targetIndex == -1) return;

      final target = bookmarks[targetIndex];
      final repository = ref.read(bookNoteRepositoryProvider);
      await repository.deleteBookNoteById(target.id!);

      // Reload to ensure consistency
      await loadNotes(types: _types);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
