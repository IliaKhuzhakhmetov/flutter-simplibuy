import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/domain/entities/item_view.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  final ItemView item;

  const ItemListTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Text(
        '${item.quantity}',
        style: context.titleLarge,
      ),
      title: Text(
        item.name,
        style: context.titleLarge,
      ),
      subtitle: Text(
        '${item.normalPrice} \$',
        style: context.titleMedium,
      ),
    );
  }
}
