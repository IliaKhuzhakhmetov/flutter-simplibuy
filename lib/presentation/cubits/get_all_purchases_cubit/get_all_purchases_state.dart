import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// Base state class for representing the various states of fetching all purchases.
sealed class GetAllPurchasesState extends Equatable {
  const GetAllPurchasesState();

  @override
  List<Object?> get props => [];
}

/// Represents the initial state before any action has been taken.
class GetAllPurchasesInitial extends GetAllPurchasesState {
  const GetAllPurchasesInitial();
}

/// Represents the state when purchases are currently being fetched.
class GetAllPurchasesFetching extends GetAllPurchasesState {
  const GetAllPurchasesFetching();
}

/// Represents the state when all purchases have been successfully fetched.
class GetAllPurchasesFetched extends GetAllPurchasesState {
  final List<PurchaseView> purchases;

  const GetAllPurchasesFetched({required this.purchases});

  @override
  List<Object?> get props => [purchases];
}

/// Represents the state when there was an error fetching the purchases.
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
