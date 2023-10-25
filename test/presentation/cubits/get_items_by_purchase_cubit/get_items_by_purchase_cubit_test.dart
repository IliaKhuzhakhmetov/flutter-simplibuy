import 'package:bloc_test/bloc_test.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/repositories/items.repository.dart';
import 'package:e_shop_flutter/presentation/cubits/get_items_by_purchase_cubit/get_Items_by_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/get_items_by_purchase_cubit/get_items_by_purchase.state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late GetItemsByPurchaseCubit getItemsByPurchaseCubit;
  late MockItemsRepository mockItemsRepository;

  setUp(() {
    mockItemsRepository = MockItemsRepository();
    getItemsByPurchaseCubit = GetItemsByPurchaseCubit(
      itemsRepository: mockItemsRepository,
    );
  });

  final tPurchase = PurchaseView(
    id: 1,
    name: 'Test Purchase',
    sum: 1.0,
    date: DateTime.now(),
  );
  final tException = Exception();

  tearDown(() => getItemsByPurchaseCubit.close());

  test('initial state is GetItemsByPurchaseInitial', () {
    expect(getItemsByPurchaseCubit.state,
        equals(const GetItemsByPurchaseInitial()));
  });

  blocTest<GetItemsByPurchaseCubit, GetItemsByPurchaseState>(
    'emits [GetItemsByPurchaseFetching, GetItemsByPurchaseFetched] when loadItems is successful',
    setUp: () {
      when(() => mockItemsRepository.getItemsByPurchaseId(any())).thenAnswer(
          (_) async => <ItemView>[]); // Assume Item is a defined class
    },
    build: () => getItemsByPurchaseCubit,
    act: (cubit) => cubit.loadItems(tPurchase),
    expect: () => <GetItemsByPurchaseState>[
      const GetItemsByPurchaseFetching(),
      const GetItemsByPurchaseFetched(items: <ItemView>[]),
    ],
  );

  blocTest<GetItemsByPurchaseCubit, GetItemsByPurchaseState>(
    'emits [GetItemsByPurchaseFetching, GetItemsByPurchaseFailed] when loadItems is unsuccessful',
    setUp: () {
      when(() => mockItemsRepository.getItemsByPurchaseId(any()))
          .thenThrow(tException);
    },
    build: () => getItemsByPurchaseCubit,
    act: (cubit) => cubit.loadItems(tPurchase),
    expect: () => [
      const GetItemsByPurchaseFetching(),
      isA<GetItemsByPurchaseFailed>(),
    ],
  );

  blocTest<GetItemsByPurchaseCubit, GetItemsByPurchaseState>(
    'does not emit any states if the state is already GetItemsByPurchaseFetching',
    build: () => getItemsByPurchaseCubit,
    seed: () => const GetItemsByPurchaseFetching(),
    act: (cubit) => cubit.loadItems(tPurchase),
    expect: () => [],
  );
}
