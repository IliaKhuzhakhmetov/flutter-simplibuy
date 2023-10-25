import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents the different states of the process of fetching items associated with a purchase.
///
/// This sealed class `GetItemsByPurchaseState` serves as the base for the various states
/// that the [GetItemsByPurchaseCubit] can be in during the fetching process.
///
/// States:
///   - [GetItemsByPurchaseInitial]: The initial state before any fetching operation begins.
///   - [GetItemsByPurchaseFetching]: Represents the state when the fetching process is ongoing.
///   - [GetItemsByPurchaseFetched]: Represents a successful fetch state and contains the fetched items.
///   - [GetItemsByPurchaseFailed]: Represents a failure in fetching items. Contains the exception
///     leading to the failure and a callback to retry the fetch operation.
sealed class GetItemsByPurchaseState extends Equatable {
  const GetItemsByPurchaseState();

  @override
  List<Object?> get props => [];
}

class GetItemsByPurchaseInitial extends GetItemsByPurchaseState {
  const GetItemsByPurchaseInitial();
}

class GetItemsByPurchaseFetching extends GetItemsByPurchaseState {
  const GetItemsByPurchaseFetching();
}

class GetItemsByPurchaseFetched extends GetItemsByPurchaseState {
  final List<ItemView> items;

  const GetItemsByPurchaseFetched({required this.items});

  @override
  List<Object?> get props => [items];
}

class GetItemsByPurchaseFailed extends GetItemsByPurchaseState {
  final Exception exception;
  final VoidCallback? tryAgain;

  const GetItemsByPurchaseFailed({required this.exception, this.tryAgain});

  @override
  List<Object?> get props => [exception, tryAgain];
}
