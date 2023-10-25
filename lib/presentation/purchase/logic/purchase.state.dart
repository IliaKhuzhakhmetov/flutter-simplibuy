import 'package:e_shop_flutter/core/base/state_mixins.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.state.freezed.dart';

@freezed
abstract class PurchaseState with _$PurchaseState {
  @With<StateForBuilder>()
  const factory PurchaseState.initial() = _PurchaseInitial;
  @With<StateForBuilder>()
  const factory PurchaseState.itemsFetched(List<ItemView> items) =
      _PurchaseItemsFetched;
}
