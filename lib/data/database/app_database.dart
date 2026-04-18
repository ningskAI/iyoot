import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database?> get database async {
    if (_database != null) {
      // 直接返回现有数据库链接，避免重复版本检查
      return _database;
    }
    try {
      _database = await _initDB("ireader.db");
      return _database;
    } catch (e) {
      return null;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 7, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    const createBookSQL = '''
      CREATE TABLE tb_books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        coverPath TEXT,
        filePath TEXT,
        lastReadPosition TEXT,
        readingPercentage REAL,
        author TEXT,
        isDeleted INTEGER,
        description TEXT,
        createTime TEXT,
        updateTime TEXT
      )
      ''';

    const createThemeSQL = '''
      CREATE TABLE tb_themes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        backgroundColor TEXT,
        textColor TEXT,
        backgroundImagePath TEXT
      )
      ''';

    const createStyleSQL = '''
      CREATE TABLE tb_styles (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fontSize REAL,
        fontFamily TEXT,
        lineHeight REAL,
        letterSpacing REAL,
        wordSpacing REAL,
        paragraphSpacing REAL,
        sideMargin REAL,
        topMargin REAL,
        bottomMargin REAL
      )
      ''';

    const primaryTheme1 = '''
      INSERT INTO tb_themes (backgroundColor, textColor, backgroundImagePath) VALUES ('fffbfbf3', 'ff343434', '')
      ''';
    const primaryTheme2 = '''
      INSERT INTO tb_themes (backgroundColor, textColor, backgroundImagePath) VALUES ('ff040404', 'fffeffeb', '')
      ''';

    const createNoteSQL = '''
      CREATE TABLE tb_notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bookId INTEGER,
        content TEXT,
        cfi TEXT,
        chapter TEXT,
        type TEXT,
        color TEXT,
        createTime TEXT,
        updateTime TEXT
      )
      ''';

    const createReadingTimeSQL = '''
      CREATE TABLE tb_reading_time (
        id INTEGER PRIMARY KEY,
        bookId INTEGER,
        date TEXT,
        readingTime INTEGER
      )
      ''';

    const createGroupSQL = '''
      CREATE TABLE tb_groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        parentId INTEGER,
        isDeleted INTEGER DEFAULT 0,
        createTime TEXT,
        updateTime TEXT,
        FOREIGN KEY (parentId) REFERENCES tb_groups(id)
      )
      ''';
    await db.execute(createBookSQL);
    await db.execute(createNoteSQL);
    await db.execute(createThemeSQL);
    await db.execute(createStyleSQL);
    await db.execute(createReadingTimeSQL);
    await db.execute(primaryTheme1);
    await db.execute(primaryTheme2);
    await db.execute(createGroupSQL);
  }
}
