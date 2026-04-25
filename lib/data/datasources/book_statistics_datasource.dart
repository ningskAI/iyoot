import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/book_extra.dart';

abstract class BookStatisticsDatasource extends BaseDatasource {
  Future<List<BookExtra>> getBookExtraList();
}
