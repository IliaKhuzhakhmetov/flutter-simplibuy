import 'package:e_shop_flutter/core/utils/pair.dart';
import 'package:flutter/material.dart';

class AddItemDialog extends StatefulWidget {
  const AddItemDialog({super.key});

  @override
  State<AddItemDialog> createState() => _AddItemDialogState();
}

class _AddItemDialogState extends State<AddItemDialog> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final canAdd =
        nameController.text.isNotEmpty && priceController.text.isNotEmpty;

    return AlertDialog(
      title: const Text('Add new item to the virtual basket'),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Enter the name',
                ),
                onChanged: (_) {
                  formKey.currentState?.validate();
                  setState(() {});
                },
                validator: _nameValidator,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  hintText: 'Enter the price',
                ),
                validator: _priceValidator,
                onChanged: (_) {
                  formKey.currentState?.validate();
                  setState(() {});
                },
              )
            ],
          )),
      actions: [
        TextButton(
          onPressed: canAdd ? () => _addPressed(context) : null,
          child: const Text('ADD'),
        ),
      ],
    );
  }

  String? _nameValidator(value) {
    return value?.isNotEmpty == true ? null : 'Please, enter the item name';
  }

  String? _priceValidator(value) {
    return value?.isNotEmpty == true &&
            double.tryParse(value?.replaceAll(',', '.') ?? '') != null
        ? null
        : 'Please, enter the item price';
  }

  void _addPressed(BuildContext context) => Navigator.pop(
        context,
        Pair<String, String>(
          nameController.text,
          nameController.text,
        ),
      );
}
