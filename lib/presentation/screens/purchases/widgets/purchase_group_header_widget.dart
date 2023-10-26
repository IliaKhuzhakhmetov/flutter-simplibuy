import 'package:e_shop_flutter/core/extensions/context.extension.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:flutter/material.dart';

class PurchaseGroupHeaderWidget extends StatelessWidget {
  final Pair<String, String> dateAndSum;

  const PurchaseGroupHeaderWidget({required this.dateAndSum, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateAndSum.first,
                style: context.headlineMedium,
              ),
              Text(
                '${dateAndSum.second} \$',
                style: context.titleLarge,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
