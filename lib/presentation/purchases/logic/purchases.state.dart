import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:equatable/equatable.dart';

sealed class PurchasesState extends Equatable {
  const PurchasesState();

  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchasesState {
  const PurchaseInitial();
}

class PurchasesFetching extends PurchasesState {
  const PurchasesFetching();
}

class PurchasesFetched extends PurchasesState {
  final List<PurchaseView> purchases;

  const PurchasesFetched({required this.purchases});

  @override
  List<Object?> get props => [purchases];
}

class PurchasesFailed extends PurchasesState {
  final Exception exception;

  const PurchasesFailed({required this.exception});

  @override
  List<Object?> get props => [exception];
}
