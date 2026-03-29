import 'package:drift/drift.dart';

class ClcCategories extends Table {
  TextColumn get code => text().withLength(min: 1, max: 1)();
  TextColumn get name => text()();
  @override
  Set<Column<Object>>? get primaryKey => {code};
}
