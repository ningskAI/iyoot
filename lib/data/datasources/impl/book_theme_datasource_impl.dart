import 'package:i_reader/data/datasources/book_theme_datasource.dart';
import 'package:i_reader/data/models/read_theme.dart';

class BookThemeDatasourceImpl extends BookThemeDatasource {
  @override
  Future<void> deleteTheme(int id) {
    // TODO: implement deleteTheme
    throw UnimplementedError();
  }

  @override
  Future<int> insertTheme(ReadTheme readTheme) {
    return insert('tb_themes', readTheme.toJson().remove('id'));
  }

  @override
  Future<ReadTheme> selectReadThemeById(int id) async {
    final theme = await querySingle(
      'tb_themes',
      mapper: ReadTheme.fromJson,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (theme == null) {
      throw StateError('Theme with id $id not found');
    }
    return theme;
  }

  @override
  Future<List<ReadTheme>> selectThemes() {
    return queryList('tb_themes', mapper: ReadTheme.fromJson);
  }

  @override
  Future<void> updateTheme(ReadTheme readTheme) async {
    await update(
      'tb_themes',
      readTheme.toJson(),
      where: 'id = ?',
      whereArgs: [readTheme.id],
    );
  }
}
