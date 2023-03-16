extension StringExtensions on String {
  String getDecimalValue() {
    if (split('.')[1] == '00') {
      return replaceAll('.00', '');
    } else {
      return this;
    }
  }
}
