import 'package:e_shop_flutter/core/base/state_mixins.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_purchase.state.freezed.dart';

@freezed
abstract class AddPurchaseState with _$AddPurchaseState {
  @With<StateForBuilder>()
  const factory AddPurchaseState.addPurchaseInitial() = _AddpurchaseInitial;
  @With<StateForBuilder>()
  const factory AddPurchaseState.dateChanged(DateTime date) = _DateChanged;
  @With<StateForBuilder>()
  const factory AddPurchaseState.itemsChanged(
      List<ItemView> items, int length) = _ItemsChanged;
  @With<StateForBuilder>()
  const factory AddPurchaseState.itemCountChanged(int id, int count) =
      _ItemChanged;
  @With<StateForBuilder>()
  const factory AddPurchaseState.validated({
    required bool validated,
  }) = _Validated;
  @With<StateForListener>()
  const factory AddPurchaseState.purchaseSaved() = _PurchaseSaved;
}
