enum ValueExceptionType { empty, cantParse }

extension ExValueExceptionType on ValueExceptionType {
  String get value {
    switch (this) {
      case ValueExceptionType.empty:
        return "This value can't be empty";
      case ValueExceptionType.cantParse:
        return 'The value is wrong';
    }
  }
}

@Deprecated('Use standard method for input validations [Form]')
class ValueException implements Exception {
  ValueExceptionType exceptionType;

  ValueException(this.exceptionType) : super();

  String get message => exceptionType.value;
}
