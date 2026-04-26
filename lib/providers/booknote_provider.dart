import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part 'booknote_provider.g.dart';

class BookNoteChangedEvent {
  final int bookId;
  final DateTime timestamp;

  BookNoteChangedEvent({required this.bookId, DateTime? timestamp})
      : timestamp = timestamp ?? DateTime.now();
}

final _bookNoteEventController = StreamController<BookNoteChangedEvent>.broadcast();

@Riverpod(keepAlive: true)
Stream<BookNoteChangedEvent> bookNoteEventStream(BookNoteEventStreamRef ref) {
  return _bookNoteEventController.stream;
}

@Riverpod(keepAlive: true)
Future<int> bookNoteCount(BookNoteCountRef ref, int bookId) async {
  // Listen to the event stream to invalidate/refetch when changes occur
  ref.listen(bookNoteEventStreamProvider, (_, __) {
    ref.invalidateSelf();
  });

  final repository = ref.read(bookNoteRepositoryProvider);
  
  // Fetch all notes for the book to get the total count
  // Note: For better performance, consider adding a countBookNotes method to the repository
  final notes = await repository.selectBookNotesByBookId(bookId);
  return notes.length;
}

@Riverpod(keepAlive: true)
class BookNoteNotifier extends _$BookNoteNotifier {
  int? _bookId;
  List<String>? _types;
  bool? _hasNote;
  String? _color;

  @override
  Future<List<BookNote>> build(int bookId) async {
    _bookId = bookId;
    return _fetchNotes(bookId, types: _types, hasNote: _hasNote);
  }

  Future<List<BookNote>> _fetchNotes(
    int bookId, {
    List<String>? types,
    bool? hasNote,
    String? color,
  }) async {
    final repository = ref.read(bookNoteRepositoryProvider);

    // If hasNote filter is specified, use the specialized method
    if (hasNote != null) {
      var notes = await repository.selectBookNotesByBookIdWithNote(
        bookId,
        hasNote,
      );

      // Apply type and color filter if also specified
      if (types != null && types.isNotEmpty) {
        notes = notes.where((note) => types.contains(note.type)).toList();
      }
      if (color != null) {
        notes = notes.where((note) => note.color == color).toList();
      }

      return notes;
    }

    // Otherwise use the standard method
    List<BookNote> notes = await repository.selectBookNotesByBookId(bookId);

    if (types != null && types.isNotEmpty) {
      notes = notes.where((note) => types.contains(note.type)).toList();
    }
    if (color != null) {
      notes = notes.where((note) => note.color == color).toList();
    }

    return notes;
  }

  void refreshNotes() {
    ref.invalidateSelf();
  }

  Future<void> loadNotes({
    List<String>? types,
    bool? hasNote,
    String? color,
  }) async {
    if (_bookId == null) return;
    _types = types;
    _hasNote = hasNote;
    _color = color;
    final notes = await _fetchNotes(
      _bookId!,
      types: types,
      hasNote: hasNote,
      color: color,
    );
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

  void filterByColor(String color) {
    loadNotes(types: null, hasNote: null, color: color);
  }

  Future<BookNote> addNote(BookNote note) async {
    final repository = ref.read(bookNoteRepositoryProvider);
    final id = await repository.save(note);
    final savedNote = note..id = id;

    // Reload to ensure consistency and ordering
    await loadNotes(types: _types, hasNote: _hasNote, color: _color);

    // Notify listeners of the change
    _bookNoteEventController.add(BookNoteChangedEvent(bookId: note.bookId));

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
      await loadNotes(types: _types, hasNote: _hasNote, color: _color);

      // Notify listeners of the change
      _bookNoteEventController.add(BookNoteChangedEvent(bookId: target.bookId));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
