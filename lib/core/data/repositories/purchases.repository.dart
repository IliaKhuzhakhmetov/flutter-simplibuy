import 'package:e_shop_flutter/core/data/api/local_database/database.dart';

abstract class PurchasesRepository {
  const PurchasesRepository();

  Future<int> addPurchase(PurchaseData data);
  Future<List<PurchaseData>> getPurchases();
  Future deletePurchase(PurchaseData purchaseData);
}
