import 'package:e_shop_flutter/core/data/app_settings.dart';
import 'package:flutter/material.dart';

class ChangeAppThemeBrighnessUseCase {
  final AppSettings _appSettings;

  ChangeAppThemeBrighnessUseCase({
    required AppSettings appSettings,
  }) : _appSettings = appSettings;

  Future<bool> execute(Brightness brightness) =>
      _appSettings.setThemeBrightness(brightness);
}
