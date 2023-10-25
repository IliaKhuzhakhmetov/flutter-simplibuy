import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_purchase.state.dart';

/// `DeletePurchaseCubit` is responsible for managing the state of deleting a purchase.
class DeletePurchaseCubit extends Cubit<DeletePurchaseState> {
  /// Use case for deleting a purchase.
  final DeletePurchaseUsecase _deletePurchaseUsecase;

  /// Constructor takes in a required [DeletePurchaseUsecase] for deleting a purchase.
  DeletePurchaseCubit({
    required DeletePurchaseUsecase deletePurchaseUsecase,
  })  : _deletePurchaseUsecase = deletePurchaseUsecase,
        super(const DeletePurchaseInitial());

  /// Deletes a purchase based on the provided [PurchaseView].
  ///
  /// If the current state is `DeletePurchaseDeleting`, the method returns early without performing any deletion.
  /// It emits `DeletePurchaseDeleting` before trying to delete and emits `DeletePurchaseSuccess` upon successful deletion.
  /// If an exception occurs, it emits `DeletePurchaseFailed`.
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
