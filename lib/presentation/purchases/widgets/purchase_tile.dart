import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/domain/entities/purchase_view.dart';
import 'package:e_shop_flutter/presentation/purchase/purchase.screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router_flow/go_router_flow.dart';

class PurchaseTile extends StatelessWidget {
  final PurchaseView purchase;
  final VoidCallback? onLongPressed;

  const PurchaseTile({required this.purchase, this.onLongPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPressed,
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
    );
  }
}
