import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';

abstract class ItemsRepository {
  const ItemsRepository();

  Future addItems(List<ItemData> itemsData);
  Future<List<ItemView>> getItemsBypurchaseId(int purchaseId);
}
