import 'package:e_shop_flutter/core/data/api/local_database/database.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_view.freezed.dart';
part 'item_view.g.dart';

extension ItemViewExt on ItemView {
  String get normalPrice => price.toStringAsFixed(2);
  ItemData mapToItemData(int purchaseId) {
    return ItemData(
      name: name,
      count: count,
      price: price,
      purchaseId: purchaseId,
    );
  }
}

@unfreezed
class ItemView with _$ItemView {
  factory ItemView({
    required int id,
    required String name,
    required int count,
    required double price,
  }) = _ItemView;

  factory ItemView.fromJson(Map<String, dynamic> json) =>
      _$ItemViewFromJson(json);

  factory ItemView.fromItemData(ItemData itemData) {
    return ItemView(
      id: itemData.id ?? -1,
      name: itemData.name,
      count: itemData.count,
      price: itemData.price,
    );
  }
}
