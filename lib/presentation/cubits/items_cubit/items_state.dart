import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:equatable/equatable.dart';

class ItemsState extends Equatable {
  final List<ItemView> items;
  final double totalPrice;
  const ItemsState({
    required this.items,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [items, totalPrice];
}

class ItemAdded extends ItemsState {
  final ItemView item;

  const ItemAdded(
      {required this.item, required List<ItemView> items, required double sum})
      : super(items: items, totalPrice: sum);

  @override
  List<Object?> get props => [item, ...super.props];
}

class ItemUpdated extends ItemsState {
  final ItemView item;

  const ItemUpdated(
      {required this.item, required List<ItemView> items, required double sum})
      : super(items: items, totalPrice: sum);

  @override
  List<Object?> get props => [item, ...super.props];
}

class ItemDeleted extends ItemsState {
  final ItemView item;

  const ItemDeleted(
      {required this.item, required List<ItemView> items, required double sum})
      : super(items: items, totalPrice: sum);

  @override
  List<Object?> get props => [item, ...super.props];
}
