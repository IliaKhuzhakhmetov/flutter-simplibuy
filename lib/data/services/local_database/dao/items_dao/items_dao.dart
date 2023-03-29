import 'package:drift/drift.dart';
import 'package:e_shop_flutter/data/models/item.table.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [ItemTable])
class ItemsDao extends DatabaseAccessor<LocalDatabase> with _$ItemsDaoMixin {
  ItemsDao(LocalDatabase db) : super(db);

  Future<int> insert(ItemData value) => into(item).insert(value);

  Future<void> insertValues(List<ItemData> values) =>
      batch((batch) => batch.insertAll(item, values));

  Future<List<ItemData>> getItemsByPurchaseId(int purchaseId) =>
      (select(item)..where((tbl) => tbl.purchaseId.equals(purchaseId))).get();
}
