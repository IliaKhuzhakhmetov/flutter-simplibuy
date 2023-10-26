import 'package:e_shop_flutter/domain/entities/purchase_view.dart';

abstract class PurchasesRepository {
  const PurchasesRepository();

  Future<int> addPurchase(PurchaseView purchase);

  Future<List<PurchaseView>> getPurchases();

  Future deletePurchase(PurchaseView purchase);
}
