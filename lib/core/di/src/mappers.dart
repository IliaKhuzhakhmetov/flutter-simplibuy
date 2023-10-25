part of '../di.dart';

void _registerMappers() {
  locator.registerLazySingleton(() => PurchaseMapper());
  locator.registerLazySingleton(() => ItemMapper());
}
