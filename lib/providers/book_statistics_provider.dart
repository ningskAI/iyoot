import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/providers/repository_providers.dart';

final bookNoteCountProvider = FutureProvider((ref) async {
  final ds = ref.read(bookNoteRepositoryProvider);
  return await ds.selectNumberOfNotesAndBooks();
});

final bookExtralListProvider = FutureProvider((ref) async {
  // NOTE: Ensure bookStatisticsRepositoryProvider applies the same type filter
  // ('note', 'underline', 'bookmark', 'highlight') as BookNoteDatasourceImpl
  // to match the count in bookNoteCountProvider.
  final ds = ref.read(bookStatisticsRepositoryProvider);
  return await ds.getBookExtraList();
});
