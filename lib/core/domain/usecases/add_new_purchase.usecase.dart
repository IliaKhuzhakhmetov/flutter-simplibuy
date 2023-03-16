import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/models/item/item_view.dart';
import 'package:e_shop_flutter/core/data/repositories/items.repository.dart';
import 'package:e_shop_flutter/core/data/repositories/purchases.repository.dart';
import 'package:e_shop_flutter/core/utils/list_extensions.dart';

class AddNewPurchaseUseCase {
  final PurchasesRepository _purchasesRepository;
  final ItemsRepository _itemsRepository;

  AddNewPurchaseUseCase({
    required PurchasesRepository purchasesRepository,
    required ItemsRepository itemsRepository,
  })  : _purchasesRepository = purchasesRepository,
        _itemsRepository = itemsRepository;

  Future<bool> execute({
    required String purchaseName,
    required DateTime date,
    required List<ItemView> items,
  }) async {
    final createdId = await _purchasesRepository.addPurchase(
      PurchaseData(
        name: purchaseName,
        sum: items.map((e) => e.price * e.count).toList().sum(),
        date: date,
      ),
    );

    final List<ItemData> itemsData = items
        .map(
          (itemView) => itemView.mapToItemData(createdId),
        )
        .toList();

    await _itemsRepository.addItems(itemsData);

    return true;
  }
}
