import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';

class GetPurchasesUsecase {
  final PurchasesRepository _purchasesRepository;

  GetPurchasesUsecase({required PurchasesRepository purchasesRepository})
      : _purchasesRepository = purchasesRepository;

  Future<List<PurchaseView>> call() => _purchasesRepository.getPurchases();
}
