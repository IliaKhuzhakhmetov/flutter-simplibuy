import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:flutter/material.dart';

class DeletePurchaseDialog extends StatelessWidget {
  final PurchaseView purchase;
  final VoidCallback onDeletePressed;

  const DeletePurchaseDialog({
    required this.purchase,
    required this.onDeletePressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: onDeletePressed,
          child: const Text('DELETE'),
        )
      ],
      title: Text(
        'Are you sure you want to delete the ${purchase.name.toUpperCase()}?',
      ),
    );
  }
}
