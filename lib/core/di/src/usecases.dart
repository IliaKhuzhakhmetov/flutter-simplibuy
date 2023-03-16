part of '../di.dart';

void _registerUsecases() {
  locator.registerFactory(
      () => GetSavedBrightnessUseCase(appSettings: locator.get()));

  locator.registerFactory(
      () => ChangeAppThemeBrighnessUseCase(appSettings: locator.get()));

  locator.registerFactory(
    () => AddNewPurchaseUseCase(
      purchasesRepository: locator.get(),
      itemsRepository: locator.get(),
    ),
  );

  locator.registerFactory(
    () => DeletePurchaseUsecase(purchasesRepository: locator.get()),
  );

  locator.registerFactory(
      () => GetPurchasesUsecase(purchasesRepository: locator.get()));
}
