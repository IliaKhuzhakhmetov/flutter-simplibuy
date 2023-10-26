import 'package:drift/drift.dart';

class ItemTable extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get quantity => real().withDefault(const Constant(1.0))();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  IntColumn get purchaseId => integer().nullable().customConstraint(
        'REFERENCES purchase(id) ON DELETE CASCADE',
      )();
}
