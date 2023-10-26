import 'package:e_shop_flutter/core/base/mapper.dart';
import 'package:e_shop_flutter/data/services/local_database/database.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';

class PurchaseMapper extends Mapper<PurchaseView, PurchaseTableData> {
  @override
  PurchaseView fromModel(PurchaseTableData model) => PurchaseView(
        id: model.id ?? -1,
        name: model.name,
        sum: model.sum,
        date: model.date ?? DateTime(0),
      );

  @override
  PurchaseTableData toModel(PurchaseView entity) => PurchaseTableData(
        id: entity.id,
        name: entity.name,
        sum: entity.sum,
        date: entity.date,
      );
}
