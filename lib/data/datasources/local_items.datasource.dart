import 'package:e_shop_flutter/data/services/local_database/dao/items_dao/items_dao.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';

abstract class LocalItemsDatasource {
  Future addItems(List<ItemTableData> itemsData);
  Future<List<ItemTableData>> getItemsPurchaseId(int purchaseId);
}

// TODO: Refactor ItemData to ItemView
class LocalItemsDatasourceImpl extends LocalItemsDatasource {
  final ItemsDao _dao;

  LocalItemsDatasourceImpl({
    required ItemsDao itemDao,
  }) : _dao = itemDao;

  @override
  Future<void> addItems(List<ItemTableData> itemsData) =>
      _dao.insertValues(itemsData);

  @override
  Future<List<ItemTableData>> getItemsPurchaseId(int purchaseId) =>
      _dao.getItemsByPurchaseId(purchaseId);
}
