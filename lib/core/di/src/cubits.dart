part of '../di.dart';

void _registerCubits() {
  locator.registerFactory(() => AddItemDialogCubit());

  locator.registerFactory(
    () => ApplicationCubit(
      changeAppThemeBrightnessUseCase: locator(),
      getSavedBrightnessUseCase: locator(),
    ),
  );

  // PurchaseCubit
  locator.registerFactory(() => PurchaseCubit(itemsRepository: locator()));

  // PurchasesCubit
  locator.registerFactory(
    () => PurchasesCubit(
      deletePurchaseUsecase: locator(),
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
