import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/providers/booknote_provider.dart';
import 'package:i_reader/providers/repository_providers.dart';
import 'package:i_reader/utils/app_log.dart';

/// Global note count provider (total notes across all books)
/// Automatically refreshes when any note changes
final bookNoteCountProvider = FutureProvider<Map<String, int>>((ref) async {
  // Listen to ALL note change events to invalidate global statistics
  ref.listen(bookNoteEventStreamProvider, (_, event) {
    // Invalidate on any note change since this is a global aggregate
    ref.invalidateSelf();
  });

  try {
    final ds = ref.read(bookNoteRepositoryProvider);
    return await ds.selectNumberOfNotesAndBooks();
  } catch (e) {
    AppLog.instance.put('Error fetching global note count: $e');
    return {'notes': 0, 'books': 0};
  }
});

/// Book extra list provider with note statistics
/// Automatically refreshes when any note changes
final bookExtralListProvider = FutureProvider<List>((ref) async {
  // Listen to ALL note change events to invalidate the list
  ref.listen(bookNoteEventStreamProvider, (_, event) {
    // Invalidate on any note change since book statistics may be affected
    ref.invalidateSelf();
  });

  try {
    final ds = ref.read(bookNoteRepositoryProvider);
    return await ds.getBookExtraList();
  } catch (e) {
    AppLog.instance.put('Error fetching book extra list: $e');
    rethrow;
  }
});
