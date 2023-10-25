import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';

import 'get_items_by_purchase.state.dart';

/// [GetItemsByPurchaseCubit] is responsible for fetching items associated with a specific purchase.
///
/// This Cubit manages states related to the process of retrieving items
/// by a particular purchase's ID. It interacts with [ItemsRepository]
/// to get the required data and emit the corresponding state.
///
/// Constructor:
///   Requires an instance of [ItemsRepository] to fetch the data.
///
/// Methods:
///   - `loadItems`: This method initiates the fetching process. It first checks if a fetch
///     operation is already in progress. If not, it communicates with the repository to
///     get the items by the given purchase's ID and emits the respective state accordingly.
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
