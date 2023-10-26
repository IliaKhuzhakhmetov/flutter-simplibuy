import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/usecases/change_app_theme_brightness.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_saved_brightness.usecase.dart';
import 'package:flutter/material.dart';

import 'application.state.dart';

export 'application.state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final GetSavedBrightnessUseCase _getSavedBrightnessUseCase;
  final ChangeAppThemeBrightnessUseCase _changeAppThemeBrightnessUseCase;

  ApplicationCubit({
    required GetSavedBrightnessUseCase getSavedBrightnessUseCase,
    required ChangeAppThemeBrightnessUseCase changeAppThemeBrightnessUseCase,
  })  : _getSavedBrightnessUseCase = getSavedBrightnessUseCase,
        _changeAppThemeBrightnessUseCase = changeAppThemeBrightnessUseCase,
        super(const ApplicationInitial());

  Future<void> init() async {
    final brightness = await _getSavedBrightnessUseCase();

    emit(ApplicationBrightnessChanged(brightness: brightness));
  }

  Future<void> changeThemeMode(Brightness currentBrightness) async {
    final brightnessToSave = currentBrightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;

    await _changeAppThemeBrightnessUseCase(brightnessToSave);

    emit(ApplicationBrightnessChanged(brightness: brightnessToSave));
  }
}
