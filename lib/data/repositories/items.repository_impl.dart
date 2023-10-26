import 'package:drift/drift.dart';
import 'package:e_shop_flutter/core/base/mapper.dart';
import 'package:e_shop_flutter/data/datasources/local_items.datasource.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';

class ItemsRepositoryImpl extends ItemsRepository {
  // TODO: Refactor Datasource
  final LocalItemsDatasource _itemsDatasource;
  final Mapper<ItemView, ItemTableData> _itemMapper;

  const ItemsRepositoryImpl({
    required LocalItemsDatasource itemDatasource,
    required Mapper<ItemView, ItemTableData> itemMapper,
  })  : _itemMapper = itemMapper,
        _itemsDatasource = itemDatasource;

  @override
  Future addItems(List<ItemView> items) => _itemsDatasource.addItems(
        items
            .map(
              (item) => _itemMapper.toModel(item).copyWith(
                    id: const Value(null),
                  ),
            )
            .toList(),
      );

  @override
  Future<List<ItemView>> getItemsByPurchaseId(int purchaseId) =>
      _itemsDatasource.getItemsPurchaseId(purchaseId).then(
            (values) => values
                .map(
                  (value) => _itemMapper.fromModel(value),
                )
                .toList(),
          );
}
