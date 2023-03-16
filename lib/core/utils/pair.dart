class Pair<T, B> {
  T first;
  B second;

  Pair(
    this.first,
    this.second,
  );

  Pair<T, B> copyWith({
    T? first,
    B? second,
  }) {
    return Pair<T, B>(
      first ?? this.first,
      second ?? this.second,
    );
  }

  @override
  String toString() => 'Pair(first: $first, second: $second)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Pair<T, B> &&
        other.first == first &&
        other.second == second;
  }

  @override
  int get hashCode => first.hashCode ^ second.hashCode;
}
