import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/event_bus_provider.dart';
import 'package:i_reader/providers/repository_providers.dart';

final bookshelfBooksProvider =
    AsyncNotifierProvider<BookshelfNotifier, List<Book>>(BookshelfNotifier.new);

class BookshelfNotifier extends AsyncNotifier<List<Book>> {
  @override
  FutureOr<List<Book>> build() async {
    ref.listen(bookCollectionEventProvider, (_, next) {
      if (next.hasValue) unawaited(reload());
    });
    return _loadShelfBooks();
  }

  Future<List<Book>> _loadShelfBooks() async {
    final repository = ref.read(bookRepositoryProvider);
    final books = await repository.selectBooks();
    return books;
  }

  Future<void> reload({bool showLoading = false}) async {
    if (showLoading || !state.hasValue) {
      state = const AsyncValue.loading();
    }
    state = await AsyncValue.guard(_loadShelfBooks);
  }

  Future<void> addBook(Book book) async {
    await ref.read(bookRepositoryProvider).insertBook(book);
    final current = state.valueOrNull;
    if (current == null) {
      await reload();
      return;
    }
    state = AsyncValue.data([
      ...current.where((item) => item.id != book.id),
      book,
    ]);
  }
}
