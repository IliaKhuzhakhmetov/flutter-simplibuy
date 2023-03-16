import 'package:e_shop_flutter/core/data/models/purchase_view.dart';
import 'package:e_shop_flutter/core/data/repositories/purchases.repository.dart';

class DeletePurchaseUsecase {
  final PurchasesRepository _purchasesRepository;

  DeletePurchaseUsecase({
    required PurchasesRepository purchasesRepository,
  }) : _purchasesRepository = purchasesRepository;

  Future<bool> execute(PurchaseView purchase) => _purchasesRepository
      .deletePurchase(purchase.mapToPurchaseData())
      .then((result) => true);
}
