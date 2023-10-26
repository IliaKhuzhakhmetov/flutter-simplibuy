import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

sealed class AddPurchaseState extends Equatable {
  const AddPurchaseState();

  @override
  List<Object?> get props => [];
}

class AddPurchaseInitial extends AddPurchaseState {
  const AddPurchaseInitial();
}

class AddPurchaseLoading extends AddPurchaseState {
  const AddPurchaseLoading();
}

class AddPurchaseSuccess extends AddPurchaseState {
  const AddPurchaseSuccess();
}

class AddPurchaseFailure extends AddPurchaseState {
  final Exception exception;
  final VoidCallback? onTryAgain;

  const AddPurchaseFailure({required this.exception, required this.onTryAgain});
}
