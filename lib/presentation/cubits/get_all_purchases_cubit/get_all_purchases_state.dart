import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

sealed class GetAllPurchasesState extends Equatable {
  const GetAllPurchasesState();

  @override
  List<Object?> get props => [];
}

class GetAllPurchasesInitial extends GetAllPurchasesState {
  const GetAllPurchasesInitial();
}

class GetAllPurchasesFetching extends GetAllPurchasesState {
  const GetAllPurchasesFetching();
}

class GetAllPurchasesFetched extends GetAllPurchasesState {
  final List<PurchaseView> purchases;

  const GetAllPurchasesFetched({required this.purchases});

  @override
  List<Object?> get props => [purchases];
}

class GetAllPurchasesFailed extends GetAllPurchasesState {
  final Exception exception;
  final VoidCallback? onTryAgain;

  const GetAllPurchasesFailed({
    required this.exception,
    this.onTryAgain,
  });

  @override
  List<Object?> get props => [exception, onTryAgain];
}
