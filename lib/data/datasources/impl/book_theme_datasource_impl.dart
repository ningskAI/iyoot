import 'package:i_reader/data/datasources/book_theme_datasource.dart';
import 'package:i_reader/data/models/reading_theme.dart';

class BookThemeDatasourceImpl extends BookThemeDatasource {
  @override
  Future<void> deleteTheme(int id) async {
    final currentThemes = await queryList(
      'tb_themes',
      mapper: ReadingTheme.fromJson,
    );
    if (currentThemes.length <= 2) {
      return;
    }

    await delete('tb_themes', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> insertTheme(ReadingTheme readTheme) {
    return insert('tb_themes', readTheme.toJson().remove('id'));
  }

  @override
  Future<ReadingTheme> selectReadThemeById(int id) async {
    final theme = await querySingle(
      'tb_themes',
      mapper: ReadingTheme.fromJson,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (theme == null) {
      throw StateError('Theme with id $id not found');
    }
    return theme;
  }

  @override
  Future<List<ReadingTheme>> selectThemes() {
    return queryList('tb_themes', mapper: ReadingTheme.fromJson);
  }

  @override
  Future<void> updateTheme(ReadingTheme readTheme) async {
    await update(
      'tb_themes',
      readTheme.toJson(),
      where: 'id = ?',
      whereArgs: [readTheme.id],
    );
  }
}
