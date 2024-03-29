part of '../di.dart';

void _registerCubits() {
  locator.registerFactory(() => ItemsCubit());

  locator.registerFactory(() => PickDateCubit());

  locator.registerFactory(() => ValidationCubit());

  locator.registerFactory(
    () => DeletePurchaseCubit(deletePurchaseUsecase: locator()),
  );

  locator.registerFactory(
    () => ApplicationCubit(
      changeAppThemeBrightnessUseCase: locator(),
      getSavedBrightnessUseCase: locator(),
    ),
  );

  // PurchaseCubit
  locator.registerFactory(
      () => GetItemsByPurchaseCubit(itemsRepository: locator()));

  // PurchasesCubit
  locator.registerFactory(
    () => GetAllPurchasesCubit(
      getPurchasesUsecase: locator(),
    ),
  );

  // AddPurchaseCubit
  locator.registerFactory(
    () => AddPurchaseCubit(
      addNewPurchaseUseCase: locator(),
    ),
  );
}
