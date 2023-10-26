import 'package:e_shop_flutter/data/services/app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class GetSavedBrightnessUseCase {
  final AppSettings _appSettings;

  GetSavedBrightnessUseCase({required AppSettings appSettings})
      : _appSettings = appSettings;

  Future<Brightness> call() => _appSettings.getThemeBrightness();
}
