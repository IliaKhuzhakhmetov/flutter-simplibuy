import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'validation_state.dart';

export 'validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(const ValidationState(isValid: false));

  void validate(GlobalKey<FormState> formKey,
      {bool Function()? additionalCheck}) {
    final isValid = (formKey.currentState?.validate() ?? false) &&
        (additionalCheck?.call() ?? true);

    emit(ValidationState(isValid: isValid));
  }
}
