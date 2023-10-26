import 'package:e_shop_flutter/core/utils/list_extensions.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';
import 'package:e_shop_flutter/domain/repositories/purchases.repository.dart';

class AddNewPurchaseUseCase {
  final PurchasesRepository _purchasesRepository;
  final ItemsRepository _itemsRepository;

  AddNewPurchaseUseCase({
    required PurchasesRepository purchasesRepository,
    required ItemsRepository itemsRepository,
  })  : _purchasesRepository = purchasesRepository,
        _itemsRepository = itemsRepository;

  Future<bool> call({
    required String purchaseName,
    required DateTime date,
    required List<ItemView> items,
  }) async {
    final purchaseId = await _purchasesRepository.addPurchase(
      PurchaseView(
        id: -1,
        name: purchaseName,
        sum: items.map((e) => e.price * e.quantity).toList().sum(),
        date: date,
      ),
    );

    await _itemsRepository.addItems(
      items
          .map((item) => item.copyWith(
                purchaseId: purchaseId,
              ))
          .toList(),
    );

    return true;
  }
}
