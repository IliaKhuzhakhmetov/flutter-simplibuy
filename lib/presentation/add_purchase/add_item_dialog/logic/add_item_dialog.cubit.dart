import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'add_item_dialog.state.dart';

class AddItemDialogCubit extends Cubit<AddItemDialogState> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  AddItemDialogCubit() : super(const AddItemDialogState.initial());

  bool get canAdd => nameC.text.isNotEmpty && priceC.text.isNotEmpty;

  void validate(String? _) {
    final validated = formKey.currentState?.validate() ?? true;

    emit(AddItemDialogState.validated(validated: validated));
  }
}
