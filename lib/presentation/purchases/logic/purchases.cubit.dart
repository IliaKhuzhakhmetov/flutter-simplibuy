import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/core/utils/list_extensions.dart';
import 'package:e_shop_flutter/core/utils/string_extensions.dart';
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
        super(const PurchasesState(purchases: [])) {
    fetch();
  }

  final List<PurchaseView> purchases = [];

  String getSumByDate(String date) =>
      '${purchases.where((element) => element.stringDate == date).map((e) => e.sum).toList().sum()}'
          .getDecimalValue();

  void fetch() => _getPurchasesUsecase().then(
        (list) {
          purchases
            ..clear()
            ..addAll(list);
          emit(state.copyWith(purchases: [...purchases]));
        },
      );

  void delete(PurchaseView purchase) => _deletePurchaseUsecase(purchase).then(
        (value) => fetch(),
      );
}
