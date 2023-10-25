import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
