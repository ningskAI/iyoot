import 'package:i_reader/data/datasources/book_statistics_datasource.dart';
import 'package:i_reader/data/models/book_extra.dart';

class BookStatisticsDatasourceImpl extends BookStatisticsDatasource {
  @override
  Future<List<BookExtra>> getBookExtraList() async {
    String sql =
        "select b.id AS bookId, b.title, b.coverPath, b.filePath, b.author, b.readingPercentage, COUNT(n.id) AS numberOfNotes," +
        " COALESCE(SUM(rt.readingTime),0) AS readingTime from tb_notes n LEFT JOIN tb_books b ON b.id = n.bookId " +
        " LEFT JOIN tb_reading_time rt ON n.bookId = rt.bookId GROUP BY n.bookId";

    return await rawQueryList(sql, mapper: BookExtra.fromJson);
  }
}
