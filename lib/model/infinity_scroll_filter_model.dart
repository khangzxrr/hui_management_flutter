class InfinityScrollFilter {
  String? value;
  final String name;
  final String label;
  final bool textFilter;
  final bool isShow;
  final bool isAlwaysOn;

  InfinityScrollFilter({
    required this.label,
    required this.name,
    required this.textFilter,
    this.isShow = true,
    this.isAlwaysOn = false,
  });

  @override
  bool operator ==(other) {
    if (other is! InfinityScrollFilter) {
      return false;
    }

    return name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return '{label: $label, name: $name, value: $value, textFiler: $textFilter isShow: $isShow}';
  }
}
