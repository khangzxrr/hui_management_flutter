class InfinityScrollFilter implements Comparable<InfinityScrollFilter> {
  String? value;
  final String name;
  final String label;
  final bool textFilter;

  InfinityScrollFilter({required this.label, required this.name, required this.textFilter});

  @override
  int compareTo(other) {
    return value == other.value ? 1 : -1;
  }

  @override
  String toString() {
    return '{label: $label, name: $name, value: $value, textFiler: $textFilter}';
  }
}
