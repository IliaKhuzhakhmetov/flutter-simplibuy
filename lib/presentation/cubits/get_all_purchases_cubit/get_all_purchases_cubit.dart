import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';

import 'get_all_purchases_state.dart';

class GetAllPurchasesCubit extends Cubit<GetAllPurchasesState> {
  final GetPurchasesUsecase _getPurchasesUsecase;

  GetAllPurchasesCubit({
    required GetPurchasesUsecase getPurchasesUsecase,
  })  : _getPurchasesUsecase = getPurchasesUsecase,
        super(const GetAllPurchasesInitial());

  Future<void> fetch() async {
    if (state is GetAllPurchasesFetching) return;

    emit(const GetAllPurchasesFetching());

    try {
      final result = await _getPurchasesUsecase();

      emit(GetAllPurchasesFetched(purchases: result));
    } on Exception catch (exception) {
      emit(GetAllPurchasesFailed(exception: exception));
    }
  }
}
