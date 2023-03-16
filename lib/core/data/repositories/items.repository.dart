import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/models/item/item_view.dart';

abstract class ItemsRepository {
  const ItemsRepository();

  Future addItems(List<ItemData> itemsData);
  Future<List<ItemView>> getItemsBypurchaseId(int purchaseId);
}
