import 'package:drift/drift.dart';
import 'package:e_shop_flutter/data/models/purchase.table.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [PurchaseTable])
class PurchaseDao extends DatabaseAccessor<LocalDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(LocalDatabase db) : super(db);

  Future deletePurchase(PurchaseTableData data) => delete(purchaseTable).delete(
        data,
      );

  Future<List<PurchaseTableData>> getPurchases() => (select(purchaseTable)
        ..orderBy(
          [
            (u) => OrderingTerm(
                  expression: u.date.cast<DateTime>(),
                  mode: OrderingMode.desc,
                ),
            (u) => OrderingTerm(
                expression: u.sum.cast<double>(), mode: OrderingMode.desc)
          ],
        ))
      .get();

  Future<int> insert(PurchaseTableData value) =>
      into(purchaseTable).insert(value);
}
