import 'dart:convert';

class ItemView {
  final int id;
  final String name;
  double quantity;
  final double price;
  final int purchaseId;

  String get normalPrice => price.toStringAsFixed(2);

  ItemView({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.purchaseId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'count': quantity,
      'price': price,
      'purchaseId': purchaseId,
    };
  }

  factory ItemView.fromMap(Map<String, dynamic> map) {
    return ItemView(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      quantity: map['count']?.toInt() ?? 0,
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
    double? quantity,
    double? price,
    int? purchaseId,
  }) {
    return ItemView(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      purchaseId: purchaseId ?? this.purchaseId,
    );
  }

  @override
  String toString() {
    return 'ItemView(id: $id, name: $name, quantity: $quantity, price: $price, purchaseId: $purchaseId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemView &&
        other.id == id &&
        other.name == name &&
        other.quantity == quantity &&
        other.price == price &&
        other.purchaseId == purchaseId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        purchaseId.hashCode;
  }
}
