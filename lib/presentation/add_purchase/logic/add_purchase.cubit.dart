import 'package:bloc/bloc.dart';
import 'package:e_shop_flutter/core/utils/list_extensions.dart';
import 'package:e_shop_flutter/core/utils/string_extensions.dart';
import 'package:e_shop_flutter/domain/entities/item/item_view.dart';
import 'package:e_shop_flutter/domain/usecases/add_new_purchase.usecase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_purchase.state.dart';

const int year = 365;

class AddPurchaseCubit extends Cubit<AddPurchaseState> {
  final formKey = GlobalKey<FormState>();
  final AddNewPurchaseUseCase _addNewPurchaseUseCase;

  AddPurchaseCubit({
    required AddNewPurchaseUseCase addNewPurchaseUseCase,
  })  : _addNewPurchaseUseCase = addNewPurchaseUseCase,
        super(const AddPurchaseState.addPurchaseInitial());

  // Data
  final TextEditingController purchaseNameController = TextEditingController();
  String get purchaseNameText => purchaseNameController.text;

  final List<ItemView> _items = [];
  List<ItemView> get items => _items;
  String get sum => _items
      .map((e) => e.price * e.count)
      .toList()
      .sum()
      .toStringAsFixed(2)
      .getDecimalValue();

  DateTime _date = DateTime.now();
  String get date => DateFormat('dd MMMM yyyy').format(_date);

  bool get canSave => purchaseNameText.isNotEmpty && _items.isNotEmpty;

  void validatePurchaseName(String? _) {
    final validated =
        (formKey.currentState?.validate() ?? false) && _items.isNotEmpty;

    emit(AddPurchaseState.validated(validated: validated));
  }

  void addItem({
    required String itemName,
    required String itemPrice,
  }) {
    _items.add(ItemView(
      id: _items.length,
      name: itemName,
      count: 1,
      price: double.tryParse(itemPrice.replaceAll(',', '.')) ?? 0,
    ));
    emit(AddPurchaseState.itemsChanged(_items, _items.length));
  }

  void pickDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime.now().subtract(const Duration(days: year)),
        lastDate: DateTime.now().add(const Duration(days: year)),
      ).then(
        (value) {
          if (value != null) {
            _date = value;
            emit(AddPurchaseState.dateChanged(_date));
          }
        },
      );

  void updateItemCounts(ItemView item) =>
      emit(AddPurchaseState.itemCountChanged(item.id, item.count));

  void deleteItem(ItemView item) {
    _items.remove(item);
    emit(AddPurchaseState.itemCountChanged(item.id, item.count));
  }

  void save() {
    _addNewPurchaseUseCase(
      purchaseName: purchaseNameText,
      date: _date,
      items: _items,
    ).then(
      (value) => emit(const AddPurchaseState.purchaseSaved()),
    );
  }
}
