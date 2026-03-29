import 'package:drift/drift.dart';
import 'clc_categories.dart';

enum BookMediaType { epub, m4b, pdf, txt }

class Volumes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fileHash => text().unique()();
  TextColumn get title => text()();
  TextColumn get author => text().nullable()();
  TextColumn get publisher => text().nullable()();
  TextColumn get clcCode => text().references(ClcCategories, #code)();
  IntColumn get rating => integer().withDefault(const Constant(0))();
  TextColumn get remarks => text().nullable()();
  TextColumn get coverPath => text().nullable()();
  DateTimeColumn get createTime => dateTime().withDefault(currentDateAndTime)();
}

class VolumeLocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get volumeId => integer().references(Volumes, #id, onDelete: KeyAction.cascade)();
  IntColumn get mediaType => intEnum<BookMediaType>().withDefault(Constant(BookMediaType.epub.index))();
  TextColumn get relativePath => text()();
  IntColumn get fileSize => integer().nullable()();
}
