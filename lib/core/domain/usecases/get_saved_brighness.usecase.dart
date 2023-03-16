import 'package:e_shop_flutter/core/data/app_settings.dart';
import 'package:flutter/material.dart';

class GetSavedBrightnessUseCase {
  final AppSettings _appSettings;

  GetSavedBrightnessUseCase({
    required AppSettings appSettings,
  }) : _appSettings = appSettings;

  Future<Brightness> execute() => _appSettings.getThemeBrightness();
}
