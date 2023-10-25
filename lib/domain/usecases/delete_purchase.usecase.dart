import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';

class DeletePurchaseUsecase {
  final PurchasesRepository _purchasesRepository;

  DeletePurchaseUsecase({
    required PurchasesRepository purchasesRepository,
  }) : _purchasesRepository = purchasesRepository;

  Future<bool> call(PurchaseView purchase) => _purchasesRepository
      .deletePurchase(purchase)
      .then((result) => true);
}
