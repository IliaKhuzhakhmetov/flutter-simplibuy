import 'package:e_shop_flutter/core/base/state_mixins.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_item_dialog.state.freezed.dart';

@freezed
class AddItemDialogState with _$AddItemDialogState {
  @With<StateForBuilder>()
  const factory AddItemDialogState.initial() = _Initial;
  @With<StateForBuilder>()
  const factory AddItemDialogState.validated({
    required bool validated,
  }) = _Validated;
}
