import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/reading_theme.dart';

abstract class BookThemeDatasource extends BaseDatasource {
  Future<int> insertTheme(ReadingTheme readTheme);
  Future<List<ReadingTheme>> selectThemes();
  Future<void> deleteTheme(int id);
  Future<void> updateTheme(ReadingTheme readTheme);
  Future<ReadingTheme> selectReadThemeById(int id);
}
