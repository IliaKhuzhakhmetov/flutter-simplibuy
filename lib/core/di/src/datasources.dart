part of '../di.dart';

void registerDatasources() {
  locator.registerLazySingleton<LocalItemsDatasource>(
    () => LocalItemsDatasourceImpl(
      itemDao: locator.get<LocalDatabase>().itemsDao,
    ),
  );
}
