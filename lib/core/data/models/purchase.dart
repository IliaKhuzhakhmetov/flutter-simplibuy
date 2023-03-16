import 'package:drift/drift.dart';

class Purchase extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get sum => real().withDefault(const Constant(0.0))();
  DateTimeColumn get date =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();
}
