import 'package:e_shop_flutter/data/datasources/local_items.datasource.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';

class ItemsRepositoryImpl extends ItemsRepository {
  // TODO: Refactor Datasource
  final LocalItemsDatasource _itemsDatasource;

  const ItemsRepositoryImpl({required LocalItemsDatasource itemDatasource})
      : _itemsDatasource = itemDatasource;

  @override
  Future addItems(List<ItemData> itemsData) =>
      _itemsDatasource.addItems(itemsData);

  @override
  Future<List<ItemView>> getItemsBypurchaseId(int purchaseId) =>
      _itemsDatasource.getItemsBypurchaseId(purchaseId).then(
            (values) => values.map((e) => ItemView.fromItemData(e)).toList(),
          );
}
