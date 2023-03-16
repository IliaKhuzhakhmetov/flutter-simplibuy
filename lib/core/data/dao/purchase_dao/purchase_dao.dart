import 'package:drift/drift.dart';
import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/models/purchase.dart';

part 'purchase_dao.g.dart';

@DriftAccessor(tables: [Purchase])
class PurchaseDao extends DatabaseAccessor<LocalDatabase>
    with _$PurchaseDaoMixin {
  PurchaseDao(LocalDatabase db) : super(db);

  Future deletePurchase(PurchaseData data) => delete(purchase).delete(data);

  Future<List<PurchaseData>> getPurchases() => (select(purchase)
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

  Future<int> insert(PurchaseData value) => into(purchase).insert(value);
}
