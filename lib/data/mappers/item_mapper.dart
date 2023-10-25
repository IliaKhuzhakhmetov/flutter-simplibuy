import 'package:e_shop_flutter/core/base/mapper.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';

class ItemMapper extends Mapper<ItemView, ItemTableData> {
  @override
  ItemView fromModel(ItemTableData model) => ItemView(
        id: model.id ?? -1,
        name: model.name,
        count: model.count,
        price: model.price,
        purchaseId: model.purchaseId ?? -1,
      );

  @override
  ItemTableData toModel(ItemView entity) => ItemTableData(
        id: entity.id,
        name: entity.name,
        count: entity.count,
        price: entity.price,
        purchaseId: entity.purchaseId,
      );
}
