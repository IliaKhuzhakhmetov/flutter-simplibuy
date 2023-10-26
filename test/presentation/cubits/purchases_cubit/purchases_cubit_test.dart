import 'package:bloc_test/bloc_test.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/usecases/get_purchases.usecase.dart';
import 'package:e_shop_flutter/presentation/cubits/get_all_purchases_cubit/get_all_purchases_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockGetPurchasesUsecase extends Mock implements GetPurchasesUsecase {}

void main() {
  late GetAllPurchasesCubit purchasesCubit;
  late MockGetPurchasesUsecase mockGetPurchasesUsecase;

  setUp(() {
    mockGetPurchasesUsecase = MockGetPurchasesUsecase();
    purchasesCubit = GetAllPurchasesCubit(
      getPurchasesUsecase: mockGetPurchasesUsecase,
    );
  });

  final tException = Exception();

  tearDown(() => purchasesCubit.close());

  test('initial state is PurchasesInitial', () {
    expect(purchasesCubit.state, equals(const GetAllPurchasesInitial()));
  });

  blocTest<GetAllPurchasesCubit, GetAllPurchasesState>(
    'emits [PurchasesFetching, PurchasesFetched] when fetch is successful',
    setUp: () {
      when(() => mockGetPurchasesUsecase()).thenAnswer(
        (_) async => <PurchaseView>[],
      );
    },
    build: () {
      return purchasesCubit;
    },
    act: (cubit) => cubit.fetch(),
    expect: () => <GetAllPurchasesState>[
      const GetAllPurchasesFetching(),
      const GetAllPurchasesFetched(purchases: <PurchaseView>[]),
    ],
  );

  blocTest<GetAllPurchasesCubit, GetAllPurchasesState>(
    'emits [PurchasesFetching, PurchasesFailed] when fetch is unsuccessful',
    setUp: () {
      when(() => mockGetPurchasesUsecase()).thenThrow(tException);
    },
    build: () => purchasesCubit,
    act: (cubit) => cubit.fetch(),
    expect: () => <GetAllPurchasesState>[
      const GetAllPurchasesFetching(),
      GetAllPurchasesFailed(exception: tException),
    ],
  );

  blocTest<GetAllPurchasesCubit, GetAllPurchasesState>(
    'does not emit any states if the state is already PurchasesFetching',
    build: () => purchasesCubit,
    seed: () => const GetAllPurchasesFetching(),
    act: (cubit) => cubit.fetch(),
    expect: () => [],
  );
}
