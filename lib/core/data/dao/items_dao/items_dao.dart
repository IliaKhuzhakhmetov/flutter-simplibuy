import 'package:drift/drift.dart';
import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/models/item.dart';


part 'items_dao.g.dart';

@DriftAccessor(tables: [Item])
class ItemsDao extends DatabaseAccessor<LocalDatabase> with _$ItemsDaoMixin {
  ItemsDao(LocalDatabase db) : super(db);

  Future<int> insert(ItemData value) => into(item).insert(value);

  Future insertValues(List<ItemData> values) =>
      batch((batch) => batch.insertAll(item, values));

  Future<List<ItemData>> getItemsByPurchaseId(int purchaseId) =>
      (select(item)..where((tbl) => tbl.purchaseId.equals(purchaseId))).get();
}
