part of '../di.dart';

void _registerCubits() {
  locator.registerFactory(() => AddItemDialogCubit());

  locator.registerLazySingleton(
    () => ApplicationCubit(
      changeAppThemeBrighnessUseCase: locator.get(),
      getSavedBrightnessUseCase: locator.get(),
    ),
  );

  // PurchaseCubit
  locator.registerFactory(() => PurchaseCubit(itemsRepository: locator.get()));

  // PurchasesCubit
  locator.registerFactory(
    () => PurchasesCubit(
      deletePurchaseUsecase: locator.get(),
      getPurchasesUsecase: locator.get(),
    ),
  );

  // AddPurchaseCubit
  locator.registerFactory(
    () => AddPurchaseCubit(
      addNewPurchaseUseCase: locator.get(),
    ),
  );
}
