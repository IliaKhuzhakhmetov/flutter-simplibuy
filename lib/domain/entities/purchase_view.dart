import 'dart:convert';

import 'package:e_shop_flutter/core/utils/list_extensions.dart';
import 'package:e_shop_flutter/core/utils/string_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

extension PurchaseListExtension on List<PurchaseView> {
  String getSumByDate(String date) =>
      where((element) => element.stringDate == date)
          .map((e) => e.sum)
          .toList()
          .sum()
          .toStringAsFixed(2);
}

class PurchaseView extends Equatable {
  final int id;
  final String name;
  final double sum;
  final DateTime date;

  String get normalSum => sum.toStringAsFixed(2).getDecimalValue();
  String get stringDate => DateFormat('dd MMMM yyyy').format(date);

  const PurchaseView({
    required this.id,
    required this.name,
    required this.sum,
    required this.date,
  });

  PurchaseView copyWith({
    int? id,
    String? name,
    double? sum,
    DateTime? date,
  }) {
    return PurchaseView(
      id: id ?? this.id,
      name: name ?? this.name,
      sum: sum ?? this.sum,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'sum': sum,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PurchaseView.fromMap(Map<String, dynamic> map) {
    return PurchaseView(
      id: map['id'],
      name: map['name'],
      sum: map['sum'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchaseView.fromJson(String source) =>
      PurchaseView.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PurchaseView(id: $id, name: $name, sum: $sum, date: $date)';
  }

  @override
  List<Object?> get props => [id, name, sum, date];
}
