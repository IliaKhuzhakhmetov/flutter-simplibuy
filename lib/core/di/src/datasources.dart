part of '../di.dart';

void _registerDatasources() {
  locator.registerLazySingleton<LocalItemsDatasource>(
    () => LocalItemsDatasourceImpl(
      itemDao: locator.get<LocalDatabase>().itemsDao,
    ),
  );
}
