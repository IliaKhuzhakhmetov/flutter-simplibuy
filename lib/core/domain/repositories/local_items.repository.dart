import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:e_shop_flutter/core/data/dao/items_dao/items_dao.dart';
import 'package:e_shop_flutter/core/data/models/item/item_view.dart';
import 'package:e_shop_flutter/core/data/repositories/items.repository.dart';

class LocalItemsRepository extends ItemsRepository {
  final ItemsDao _dao;

  const LocalItemsRepository({required ItemsDao dao}) : _dao = dao;

  @override
  Future addItems(List<ItemData> itemsData) => _dao.insertValues(itemsData);

  @override
  Future<List<ItemView>> getItemsBypurchaseId(int purchaseId) => _dao
      .getItemsByPurchaseId(purchaseId)
      .then((values) => values.map((e) => ItemView.fromItemData(e)).toList());
}
