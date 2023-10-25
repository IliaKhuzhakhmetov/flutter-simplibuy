import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';

import 'purchases.state.dart';

class PurchasesCubit extends Cubit<PurchasesState> {
  final DeletePurchaseUsecase _deletePurchaseUsecase;
  final GetPurchasesUsecase _getPurchasesUsecase;

  PurchasesCubit({
    required DeletePurchaseUsecase deletePurchaseUsecase,
    required GetPurchasesUsecase getPurchasesUsecase,
  })  : _deletePurchaseUsecase = deletePurchaseUsecase,
        _getPurchasesUsecase = getPurchasesUsecase,
        super(const PurchaseInitial());

  Future<void> fetch() async {
    if (state is PurchasesFetching) return;

    emit(const PurchasesFetching());

    try {
      final result = await _getPurchasesUsecase();

      emit(PurchasesFetched(purchases: result));
    } on Exception catch (exception) {
      emit(PurchasesFailed(exception: exception));
    }
  }

  Future<void> delete({
    required List<PurchaseView> purchases,
    required PurchaseView purchase,
  }) async {
    if (state is PurchasesFetching) return;

    emit(const PurchasesFetching());

    try {
      final result = await _deletePurchaseUsecase(purchase);

      if (result) {
        purchases.remove(purchase);
      }

      emit(PurchasesFetched(purchases: purchases));
    } on Exception catch (exception) {
      emit(PurchasesFailed(exception: exception));
    }
  }
}
