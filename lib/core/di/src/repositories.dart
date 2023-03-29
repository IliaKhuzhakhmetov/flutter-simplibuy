part of '../di.dart';

void _registerRespositories() {
  locator.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      itemDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<PurchasesRepository>(
    () => PurchasesRepositoryImpl(
      dao: locator.get<LocalDatabase>().purchaseDao,
    ),
  );
}
