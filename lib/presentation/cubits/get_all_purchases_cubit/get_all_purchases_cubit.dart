import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';

import 'get_all_purchases_state.dart';

/// `GetAllPurchasesCubit` is responsible for managing the state
/// related to fetching all purchases.
///
/// It interacts with [GetPurchasesUsecase] to fetch the purchases
/// and updates the state accordingly.
class GetAllPurchasesCubit extends Cubit<GetAllPurchasesState> {
  final GetPurchasesUsecase _getPurchasesUsecase;

  /// Creates an instance of [GetAllPurchasesCubit].
  ///
  /// Requires [getPurchasesUsecase] to interact with the domain layer.
  GetAllPurchasesCubit({
    required GetPurchasesUsecase getPurchasesUsecase,
  })  : _getPurchasesUsecase = getPurchasesUsecase,
        super(const GetAllPurchasesInitial());

  /// Fetches all purchases and updates the state.
  ///
  /// If the current state is [GetAllPurchasesFetching], it avoids
  /// making another request to prevent multiple fetches.
  /// On success, it emits [GetAllPurchasesFetched] with the fetched purchases.
  /// On failure, it emits [GetAllPurchasesFailed] with the exception.
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
