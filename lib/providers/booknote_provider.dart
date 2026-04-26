import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booknote_provider.g.dart';

@Riverpod(keepAlive: true)
class BookNoteNotifier extends _$BookNoteNotifier {
  int? _bookId;
  List<String>? _types;
  bool? _hasNote;

  @override
  Future<List<BookNote>> build(int bookId) async {
    _bookId = bookId;
    return _fetchNotes(bookId, types: _types, hasNote: _hasNote);
  }

  Future<List<BookNote>> _fetchNotes(
    int bookId, {
    List<String>? types,
    bool? hasNote,
  }) async {
    final repository = ref.read(bookNoteRepositoryProvider);

    // If hasNote filter is specified, use the specialized method
    if (hasNote != null) {
      final notes = await repository.selectBookNotesByBookIdWithNote(
        bookId,
        hasNote,
      );

      // Apply type filter if also specified
      if (types != null && types.isNotEmpty) {
        return notes.where((note) => types.contains(note.type)).toList();
      }

      return notes;
    }

    // Otherwise use the standard method
    final notes = await repository.selectBookNotesByBookId(bookId);

    if (types != null && types.isNotEmpty) {
      return notes.where((note) => types.contains(note.type)).toList();
    }

    return notes;
  }

  void refreshNotes() {
    ref.invalidateSelf();
  }

  Future<void> loadNotes({List<String>? types, bool? hasNote}) async {
    if (_bookId == null) return;
    _types = types;
    _hasNote = hasNote;
    final notes = await _fetchNotes(_bookId!, types: types, hasNote: hasNote);
    state = AsyncData(notes);
  }

  // Add filter methods
  void filterByTypes(List<String> types) {
    loadNotes(types: types, hasNote: null);
  }

  void filterByHasNote(bool hasNote) {
    loadNotes(types: null, hasNote: hasNote);
  }

  void resetFilter() {
    loadNotes(types: null, hasNote: null);
  }

  Future<BookNote> addNote(BookNote note) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    final id = await repository.save(note);
    final savedNote = note..id = id;

    // Reload to ensure consistency and ordering
    await loadNotes(types: _types, hasNote: _hasNote);

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
      await loadNotes(types: _types, hasNote: _hasNote);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
