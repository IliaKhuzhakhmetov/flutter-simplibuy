import 'package:e_shop_flutter/domain/entities/item_view.dart';

abstract class ItemsRepository {
  const ItemsRepository();

  Future addItems(List<ItemView> items);
  Future<List<ItemView>> getItemsByPurchaseId(int purchaseId);
}
