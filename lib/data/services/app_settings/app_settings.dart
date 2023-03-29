import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_provider.dart';

const String brightnessKey = '_bk';

class AppSettings extends DataProvider {
  AppSettings(SharedPreferences sharedPreferences) : super(sharedPreferences);

  Future<Brightness> getThemeBrightness() async {
    final value = await get<bool>(brightnessKey, true);

    return value ? Brightness.light : Brightness.dark;
  }

  Future<bool> setThemeBrightness(Brightness brightness) => save(
        brightnessKey,
        brightness == Brightness.light,
      ).then((saved) => true);
}
