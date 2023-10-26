import 'package:bloc_test/bloc_test.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/domain/usecases/delete_purchase.usecase.dart';
import 'package:e_shop_flutter/presentation/cubits/delete_purchase_cubit/delete_purchase.cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockDeletePurchaseUsecase extends Mock implements DeletePurchaseUsecase {}

void main() {
  late DeletePurchaseCubit deletePurchaseCubit;
  late MockDeletePurchaseUsecase mockDeletePurchaseUsecase;

  setUp(() {
    mockDeletePurchaseUsecase = MockDeletePurchaseUsecase();
    deletePurchaseCubit = DeletePurchaseCubit(
      deletePurchaseUsecase: mockDeletePurchaseUsecase,
    );
  });

  final tPurchase = PurchaseView(
    id: 1,
    name: 'Test Purchase',
    sum: 20,
    date: DateTime.now(),
  );
  final tException = Exception();

  tearDown(() => deletePurchaseCubit.close());

  test('initial state is DeletePurchaseInitial', () {
    expect(deletePurchaseCubit.state, equals(const DeletePurchaseInitial()));
  });

  blocTest<DeletePurchaseCubit, DeletePurchaseState>(
    'emits [DeletePurchaseDeleting, DeletePurchaseSuccess] when delete is successful',
    setUp: () {
      when(() => mockDeletePurchaseUsecase(tPurchase)).thenAnswer(
        (_) async => true,
      );
    },
    build: () => deletePurchaseCubit,
    act: (cubit) => cubit.delete(purchase: tPurchase),
    expect: () => <DeletePurchaseState>[
      const DeletePurchaseDeleting(),
      const DeletePurchaseSuccess(),
    ],
  );

  blocTest<DeletePurchaseCubit, DeletePurchaseState>(
    'emits [DeletePurchaseDeleting, DeletePurchaseFailed] when delete is unsuccessful',
    setUp: () {
      when(() => mockDeletePurchaseUsecase(tPurchase)).thenThrow(tException);
    },
    build: () => deletePurchaseCubit,
    act: (cubit) => cubit.delete(purchase: tPurchase),
    expect: () => <DeletePurchaseState>[
      const DeletePurchaseDeleting(),
      DeletePurchaseFailed(exception: tException),
    ],
  );

  blocTest<DeletePurchaseCubit, DeletePurchaseState>(
    'does not emit any states if the state is already DeletePurchaseDeleting',
    build: () => deletePurchaseCubit,
    seed: () => const DeletePurchaseDeleting(),
    act: (cubit) => cubit.delete(purchase: tPurchase),
    expect: () => [],
  );
}
