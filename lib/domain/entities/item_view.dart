import 'dart:convert';

class ItemView {
  final int id;
  final String name;
  int count;
  final double price;
  final int purchaseId;

  String get normalPrice => price.toStringAsFixed(2);

  ItemView({
    required this.id,
    required this.name,
    required this.count,
    required this.price,
    required this.purchaseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'count': count,
      'price': price,
      'purchaseId': purchaseId,
    };
  }

  factory ItemView.fromMap(Map<String, dynamic> map) {
    return ItemView(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      count: map['count']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
      purchaseId: map['purchaseId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemView.fromJson(String source) =>
      ItemView.fromMap(json.decode(source));

  ItemView copyWith({
    int? id,
    String? name,
    int? count,
    double? price,
    int? purchaseId,
  }) {
    return ItemView(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
      price: price ?? this.price,
      purchaseId: purchaseId ?? this.purchaseId,
    );
  }

  @override
  String toString() {
    return 'ItemView(id: $id, name: $name, count: $count, price: $price, purchaseId: $purchaseId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemView &&
        other.id == id &&
        other.name == name &&
        other.count == count &&
        other.price == price &&
        other.purchaseId == purchaseId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        count.hashCode ^
        price.hashCode ^
        purchaseId.hashCode;
  }
}
