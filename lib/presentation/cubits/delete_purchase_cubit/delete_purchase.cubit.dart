import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_purchase.state.dart';

class DeletePurchaseCubit extends Cubit<DeletePurchaseState> {
  final DeletePurchaseUsecase _deletePurchaseUsecase;

  DeletePurchaseCubit({
    required DeletePurchaseUsecase deletePurchaseUsecase,
  })  : _deletePurchaseUsecase = deletePurchaseUsecase,
        super(const DeletePurchaseInitial());

  Future<void> delete({required PurchaseView purchase}) async {
    if (state is DeletePurchaseDeleting) return;

    emit(const DeletePurchaseDeleting());

    try {
      await _deletePurchaseUsecase(purchase);

      emit(const DeletePurchaseSuccess());
    } on Exception catch (exception) {
      emit(DeletePurchaseFailed(exception: exception));
    }
  }
}
