import 'package:drift/drift.dart';
import 'volumes.dart';

class Fragments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get volumeId => integer().references(Volumes, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get postionAnchor => text()();
  IntColumn get sortOrder => integer()();
}

class ReadingProgress extends Table {
  IntColumn get volumeId => integer().references(Volumes, #id, onDelete: KeyAction.cascade)();
  TextColumn get lastAnchor => text()();
  RealColumn get percentage => real().withDefault(const Constant(0.0))();
  DateTimeColumn get updateTime => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>>? get primaryKey => {volumeId};
}
