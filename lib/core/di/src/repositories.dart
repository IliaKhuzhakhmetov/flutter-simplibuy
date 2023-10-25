part of '../di.dart';

void _registerRepositories() {
  locator.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      itemMapper: locator<ItemMapper>(),
      itemDatasource: locator(),
    ),
  );

  locator.registerLazySingleton<PurchasesRepository>(
    () => PurchasesRepositoryImpl(
      purchaseMapper: locator<PurchaseMapper>(),
      dao: locator.get<LocalDatabase>().purchaseDao,
    ),
  );
}
