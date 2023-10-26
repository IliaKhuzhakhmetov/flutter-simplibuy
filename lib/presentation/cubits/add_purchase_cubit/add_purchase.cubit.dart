import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:e_shop_flutter/domain/usecases/add_new_purchase.usecase.dart';

import 'add_purchase.state.dart';

class AddPurchaseCubit extends Cubit<AddPurchaseState> {
  final AddNewPurchaseUseCase _addNewPurchaseUseCase;

  AddPurchaseCubit({
    required AddNewPurchaseUseCase addNewPurchaseUseCase,
  })  : _addNewPurchaseUseCase = addNewPurchaseUseCase,
        super(const AddPurchaseInitial());

  Future<void> save({
    required String purchaseTitle,
    required DateTime date,
    required List<ItemView> items,
  }) async {
    if (state is AddPurchaseLoading) return;

    emit(const AddPurchaseLoading());

    try {
      await _addNewPurchaseUseCase(
        purchaseName: purchaseTitle,
        date: date,
        items: items,
      );

      emit(const AddPurchaseSuccess());
    } on Exception catch (exception) {
      emit(
        AddPurchaseFailure(
          exception: exception,
          onTryAgain: () => save(
            date: date,
            purchaseTitle: purchaseTitle,
            items: items,
          ),
        ),
      );
    }
  }
}
