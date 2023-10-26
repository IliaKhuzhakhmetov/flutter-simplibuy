abstract class TextValidations {
  static String? isNotEmpty(String? value) {
    return value?.isNotEmpty == true ? null : 'Can not be empty';
  }

  static String? isCorrectPrice(String? value) {
    final parsed = double.tryParse(value?.replaceAll(',', '.') ?? '');

    return value?.isNotEmpty == true && parsed != null && parsed > 0
        ? null
        : 'Incorrect price';
  }
}
