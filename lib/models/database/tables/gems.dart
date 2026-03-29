import 'package:drift/drift.dart';
import 'volumes.dart';

class Gems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get volumeId => integer().references(Volumes, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();
  TextColumn get anchor => text()();
  DateTimeColumn get createTime => dateTime().withDefault(currentDateAndTime)();
  TextColumn get chapterTitle => text().nullable()();
}
