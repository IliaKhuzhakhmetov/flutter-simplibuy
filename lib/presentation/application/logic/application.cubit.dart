import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/usecases/change_app_theme_brighness.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_saved_brighness.usecase.dart';
import 'package:flutter/material.dart';

import 'application.state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final GetSavedBrightnessUseCase _getSavedBrightnessUseCase;
  final ChangeAppThemeBrightnessUseCase _changeAppThemeBrightnessUseCase;

  ApplicationCubit({
    required GetSavedBrightnessUseCase getSavedBrightnessUseCase,
    required ChangeAppThemeBrightnessUseCase changeAppThemeBrightnessUseCase,
  })  : _getSavedBrightnessUseCase = getSavedBrightnessUseCase,
        _changeAppThemeBrightnessUseCase = changeAppThemeBrightnessUseCase,
        super(const ApplicationState.mainInitial()) {
    init();
  }

  void init() => _getSavedBrightnessUseCase().then(
        (brightness) =>
            emit(ApplicationState.purchasesThemeChanged(brightness)),
      );

  void changeThemeMode(Brightness currentBrighnesss) {
    final brightnessToSave = currentBrighnesss == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    _changeAppThemeBrightnessUseCase(brightnessToSave).then((result) {
      emit(ApplicationState.purchasesThemeChanged(brightnessToSave));
    });
  }
}
