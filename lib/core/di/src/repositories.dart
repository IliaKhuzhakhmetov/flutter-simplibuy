part of '../di.dart';

void _registerRespositories() {
  locator.registerLazySingleton<ItemsRepository>(
    () => LocalItemsRepository(
      dao: locator.get<LocalDatabase>().itemsDao,
    ),
  );

  locator.registerLazySingleton<PurchasesRepository>(
    () => LocalPurchasesRepository(
      dao: locator.get<LocalDatabase>().purchaseDao,
    ),
  );
}
