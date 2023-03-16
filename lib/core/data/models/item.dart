import 'package:drift/drift.dart';

class Item extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get count => integer().withDefault(const Constant(1))();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  IntColumn get purchaseId =>
      integer().customConstraint('REFERENCES purchase(id) ON DELETE CASCADE')();
}
