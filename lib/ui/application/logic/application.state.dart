import 'dart:ui';

import 'package:e_shop_flutter/core/base/state_mixins.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.state.freezed.dart';

@freezed
class ApplicationState with _$ApplicationState {
  @With<StateForBuilder>()
  const factory ApplicationState.mainInitial() = _MainInitial;
  @With<StateForBuilder>()
  const factory ApplicationState.purchasesThemeChanged(Brightness brightness) =
      _PurchasesThemeChanged;
}
