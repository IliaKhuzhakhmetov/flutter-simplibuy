part of '../di.dart';

void registerDatasources() {
  locator.registerLazySingleton<LocalItemsDatasource>(
    () => LocalItemsDatasourceImpl(
      dao: locator.get<LocalDatabase>().itemsDao,
    ),
  );
}
