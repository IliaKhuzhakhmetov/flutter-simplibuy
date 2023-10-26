import 'package:drift/drift.dart';
import 'package:e_shop_flutter/data/models/item.table.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [ItemTable])
class ItemsDao extends DatabaseAccessor<LocalDatabase> with _$ItemsDaoMixin {
  ItemsDao(LocalDatabase db) : super(db);

  Future<int> insert(ItemTableData value) => into(itemTable).insert(value);

  Future<void> insertValues(List<ItemTableData> values) =>
      batch((batch) => batch.insertAll(itemTable, values));

  Future<List<ItemTableData>> getItemsByPurchaseId(int purchaseId) =>
      (select(itemTable)..where((tbl) => tbl.purchaseId.equals(purchaseId)))
          .get();
}
