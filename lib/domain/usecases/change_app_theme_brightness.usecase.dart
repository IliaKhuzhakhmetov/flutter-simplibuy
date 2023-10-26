import 'package:e_shop_flutter/data/services/app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class ChangeAppThemeBrightnessUseCase {
  final AppSettings _appSettings;

  ChangeAppThemeBrightnessUseCase({
    required AppSettings appSettings,
  }) : _appSettings = appSettings;

  Future<bool> call(Brightness brightness) =>
      _appSettings.setThemeBrightness(brightness);
}
