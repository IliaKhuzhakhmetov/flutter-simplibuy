import 'package:e_shop_flutter/core/base/injectable_state.dart';
import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:flutter/material.dart';

import 'logic/add_item_dialog.cubit.dart';
import 'logic/add_item_dialog.state.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends InjectableState<AddItemDialog,
    AddItemDialogCubit, AddItemDialogState> {
  @override
  Widget builder(BuildContext context, AddItemDialogState state) {
    return AlertDialog(
      title: const Text('Add new item to the virtual basket'),
      content: Form(
        key: cubit.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: cubit.nameC,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Enter the name',
              ),
              onChanged: cubit.validate,
              validator: (value) {
                return value?.isNotEmpty == true
                    ? null
                    : 'Plese, enter the item name';
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: cubit.priceC,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter the price',
              ),
              validator: (value) {
                return value?.isNotEmpty == true &&
                        double.tryParse(value?.replaceAll(',', '.') ?? '') !=
                            null
                    ? null
                    : 'Please, enter the item price';
              },
              onChanged: cubit.validate,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: cubit.canAdd
              ? () => Navigator.pop(
                    context,
                    Pair<String, String>(
                      cubit.nameC.text,
                      cubit.priceC.text,
                    ),
                  )
              : null,
          child: const Text('ADD'),
        )
      ],
    );
  }
}
