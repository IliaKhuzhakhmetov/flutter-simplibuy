import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';

import 'get_items_by_purchase.state.dart';

class GetItemsByPurchaseCubit extends Cubit<GetItemsByPurchaseState> {
  
  final ItemsRepository _itemsRepository;

  GetItemsByPurchaseCubit({required ItemsRepository itemsRepository})
      : _itemsRepository = itemsRepository,
        super(
          const GetItemsByPurchaseInitial(),
        );

  // TODO: Refactor to usecase
  Future<void> loadItems(PurchaseView purchase) async {
    if (state is GetItemsByPurchaseFetching) return;

    emit(const GetItemsByPurchaseFetching());

    try {
      final result = await _itemsRepository.getItemsByPurchaseId(purchase.id);

      return emit(GetItemsByPurchaseFetched(items: result));
    } on Exception catch (exception) {
      return emit(
        GetItemsByPurchaseFailed(
          exception: exception,
          tryAgain: () => loadItems(purchase),
        ),
      );
    }
  }
}
