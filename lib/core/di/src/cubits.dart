part of '../di.dart';

void _registerCubits() {
  locator.registerFactory(
    () => DeletePurchaseCubit(deletePurchaseUsecase: locator()),
  );

  locator.registerFactory(() => AddItemDialogCubit());

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
