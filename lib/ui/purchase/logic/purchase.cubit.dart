import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/core/data/repositories/items.repository.dart';

import 'purchase.state.dart';

class PurchaseCubit extends Cubit<PurchaseState> {
  final ItemsRepository _itemsRepository;

  PurchaseCubit({required ItemsRepository itemsRepository})
      : _itemsRepository = itemsRepository,
        super(const PurchaseState.initial());

  // TODO: Refactor to usecase
  void loadItems(int purchaseId) =>
      _itemsRepository.getItemsBypurchaseId(purchaseId).then(
        (items) {
          emit(PurchaseState.itemsFetched([...items]));
        },
      );
}
