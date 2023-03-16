import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DataProvider {
  final SharedPreferences _sharedPreferences;

  DataProvider(SharedPreferences sharedPreferences)
      : _sharedPreferences = sharedPreferences;

  @protected
  Future<T> get<T>(String key, T defaultValue) async {
    if (defaultValue is String) {
      return (_sharedPreferences.getString(key) ?? defaultValue) as T;
    } else if (defaultValue is int) {
      return (_sharedPreferences.getInt(key) ?? defaultValue) as T;
    } else if (defaultValue is bool) {
      return (_sharedPreferences.getBool(key) ?? defaultValue) as T;
    } else {
      throw "This type:${defaultValue.runtimeType} doesn't supported";
    }
  }

  @protected
  Future<void> save<T>(String key, T value) async {
    if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else {
      throw "This type:${value.runtimeType} doesn't supported";
    }
  }
}
