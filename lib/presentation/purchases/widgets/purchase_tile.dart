import 'package:e_shop_flutter/core/di/di.dart';
import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/cubits/delete_purchase_cubit/delete_purchase.cubit.dart';
import 'package:e_shop_flutter/presentation/cubits/delete_purchase_cubit/delete_purchase.state.dart';
import 'package:e_shop_flutter/presentation/purchase/purchase.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router_flow/go_router_flow.dart';

import 'delete_purchase_dialog.dart';

class PurchaseTile extends StatelessWidget {
  final PurchaseView purchase;
  final VoidCallback onDeleted;

  const PurchaseTile(
      {required this.purchase, required this.onDeleted, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeletePurchaseCubit>(
      create: (_) => locator(),
      child: BlocConsumer<DeletePurchaseCubit, DeletePurchaseState>(
        listener: _listener,
        builder: (context, state) => ListTile(
          onLongPress: () => _showDeleteDialog(context, purchase: purchase),
          onTap: () => context.push(
            PurchaseScreen.routeName,
            extra: purchase,
          ),
          title: Text(
            purchase.name,
            style: context.titleLarge,
          ),
          subtitle: Text(
            '${purchase.normalSum} \$',
            style: context.titleMedium,
          ),
        ),
      ),
    );
  }

  void _listener(BuildContext context, DeletePurchaseState state) {
    return switch (state) {
      DeletePurchaseSuccess() => onDeleted(),
      DeletePurchaseFailed() => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Oops, something got wrong.')),
        ),
      _ => null,
    };
  }

  void _showDeleteDialog(
    BuildContext context, {
    required PurchaseView purchase,
  }) {
    showDialog(
      context: context,
      builder: (_) => DeletePurchaseDialog(
        purchase: purchase,
        onDeletePressed: () {
          context.read<DeletePurchaseCubit>().delete(
                purchase: purchase,
              );
          Navigator.pop(context);
        },
      ),
    );
  }
}
