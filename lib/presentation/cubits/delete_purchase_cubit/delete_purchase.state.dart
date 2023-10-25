import 'package:equatable/equatable.dart';

sealed class DeletePurchaseState extends Equatable {
  const DeletePurchaseState();

  @override
  List<Object?> get props => [];
}

class DeletePurchaseInitial extends DeletePurchaseState {
  const DeletePurchaseInitial();
}

class DeletePurchaseDeleting extends DeletePurchaseState {
  const DeletePurchaseDeleting();
}

class DeletePurchaseSuccess extends DeletePurchaseState {
  const DeletePurchaseSuccess();
}

class DeletePurchaseFailed extends DeletePurchaseState {
  final Exception exception;

  const DeletePurchaseFailed({required this.exception});

  @override
  List<Object?> get props => [exception];
}
