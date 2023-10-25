part of '../di.dart';

void _registerUsecases() {
  locator.registerFactory(
    () => GetSavedBrightnessUseCase(appSettings: locator()),
  );

  locator.registerFactory(
    () => ChangeAppThemeBrightnessUseCase(appSettings: locator()),
  );

  locator.registerFactory(
    () => AddNewPurchaseUseCase(
      purchasesRepository: locator(),
      itemsRepository: locator(),
    ),
  );

  locator.registerFactory(
    () => DeletePurchaseUsecase(purchasesRepository: locator()),
  );

  locator.registerFactory(
    () => GetPurchasesUsecase(purchasesRepository: locator()),
  );
}
