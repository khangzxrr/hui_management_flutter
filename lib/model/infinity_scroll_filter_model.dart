class InfinityScrollFilter implements Comparable<InfinityScrollFilter> {
  String value;
  String name;

  InfinityScrollFilter({required this.name, required this.value});

  @override
  int compareTo(other) {
    return value == other.value ? 1 : -1;
  }

  @override
  String toString() {
    return '{name: $name, value: $value}';
  }
}
