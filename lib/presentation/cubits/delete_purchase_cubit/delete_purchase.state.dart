import 'package:equatable/equatable.dart';

/// Base class representing the different states of deleting a purchase.
/// It uses the `Equatable` package to assist with value comparison.
sealed class DeletePurchaseState extends Equatable {
  const DeletePurchaseState();

  @override
  List<Object?> get props => [];
}

/// Initial state representing the default state before any delete action is taken.
class DeletePurchaseInitial extends DeletePurchaseState {
  const DeletePurchaseInitial();
}

/// State representing the ongoing process of deleting a purchase.
class DeletePurchaseDeleting extends DeletePurchaseState {
  const DeletePurchaseDeleting();
}

/// State representing a successful deletion of a purchase.
class DeletePurchaseSuccess extends DeletePurchaseState {
  const DeletePurchaseSuccess();
}

/// State representing a failure in deleting a purchase.
/// Contains the [exception] which caused the failure.
class DeletePurchaseFailed extends DeletePurchaseState {
  final Exception exception;

  const DeletePurchaseFailed({required this.exception});

  @override
  List<Object?> get props => [exception];
}
