import 'package:equatable/equatable.dart';

class ValidationState extends Equatable {
  final bool isValid;

  const ValidationState({required this.isValid});

  @override
  List<Object?> get props => [isValid];

  ValidationState copyWith({bool? isValid}) {
    return ValidationState(isValid: isValid ?? this.isValid);
  }
}
