import 'package:e_shop_flutter/core/base/state_mixins.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchases.state.freezed.dart';

@freezed
class PurchasesState with _$PurchasesState {
  @With<StateForBuilder>()
  const factory PurchasesState({
    required List<PurchaseView> purchases,
  }) = _PurchasesState;
}
