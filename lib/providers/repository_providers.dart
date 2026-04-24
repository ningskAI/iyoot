import 'package:i_reader/data/datasources/impl/book_datasource_impl.dart';
import 'package:i_reader/data/datasources/impl/book_note_datasource_impl.dart';
import 'package:i_reader/data/datasources/impl/reading_time_datasource_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final bookRepositoryProvider = Provider((ref) {
  return BookDatasourceImpl();
});

final bookNoteRepositoryProvider = Provider((ref) {
  return BookNoteDatasourceImpl();
});

final readingTimeRepositoryProvider = Provider((ref) {
  return ReadingTimeDatasourceImpl();
});
