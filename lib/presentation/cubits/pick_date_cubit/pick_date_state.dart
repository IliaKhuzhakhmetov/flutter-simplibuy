import 'package:equatable/equatable.dart';

final class PickDateState extends Equatable {
  final DateTime date;

  const PickDateState({required this.date});

  @override
  List<Object?> get props => [date];
}
