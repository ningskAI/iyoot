import 'package:i_reader/data/datasources/base_datasource.dart';
import 'package:i_reader/data/models/read_theme.dart';

abstract class BookThemeDatasource extends BaseDatasource {
  Future<int> insertTheme(ReadTheme readTheme);
  Future<List<ReadTheme>> selectThemes();
  Future<void> deleteTheme(int id);
  Future<void> updateTheme(ReadTheme readTheme);
  Future<ReadTheme> selectReadThemeById(int id);
}
