import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';

import 'items_state.dart';

export 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit() : super(const ItemsState(items: [], totalPrice: 0));

  String totalPriceFromItems(List<ItemView> items) => items
      .map((e) => e.price * e.quantity)
      .fold(.0, (previous, current) => previous + current)
      .toStringAsFixed(2);

  void addItem({
    required List<ItemView> items,
    required String itemName,
    required String itemPrice,
  }) {
    final item = ItemView(
      id: items.length,
      name: itemName,
      quantity: 1,
      price: double.tryParse(itemPrice.replaceAll(',', '.')) ?? 0,
      purchaseId: -1,
    );
    emit(
      ItemAdded(
        item: item,
        items: [...items, item],
        sum: double.parse(totalPriceFromItems(items)),
      ),
    );
  }

  void updateItemCounts({
    required List<ItemView> items,
    required ItemView item,
  }) {
    final index = items.indexWhere((i) => i.id == item.id);

    if (index != -1) {
      items[index] = item;
      emit(
        ItemUpdated(
          item: item,
          items: items,
          sum: double.parse(totalPriceFromItems(items)),
        ),
      );
    }
  }

  void deleteItem({
    required List<ItemView> items,
    required ItemView item,
  }) {
    items.remove(item);
    emit(
      ItemDeleted(
        item: item,
        items: items,
        sum: double.parse(totalPriceFromItems(items)),
      ),
    );
  }
}
