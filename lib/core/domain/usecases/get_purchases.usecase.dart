import 'package:e_shop_flutter/core/data/models/purchase_view.dart';
import 'package:e_shop_flutter/core/data/repositories/purchases.repository.dart';

class GetPurchasesUsecase {
  final PurchasesRepository _purchasesRepository;

  GetPurchasesUsecase({
    required PurchasesRepository purchasesRepository,
  }) : _purchasesRepository = purchasesRepository;

  Future<List<PurchaseView>> execute() => _purchasesRepository
      .getPurchases()
      .then((value) => value.map((e) => e.mapToPurchaseView()).toList());
}
