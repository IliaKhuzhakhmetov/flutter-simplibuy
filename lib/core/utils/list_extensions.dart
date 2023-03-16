extension ListExtensions on List {
  List<T> addWithCopy<T>(T item) => List.from(this)..add(item);
}

extension MathListExtensions<T extends double> on List<T> {
  double sum() {
    double result = 0;
    forEach((element) => result += element);
    return result;
  }
}
