import '../model/infinity_scroll_filter_model.dart';

abstract class IFilter<T> {
  Map<String, dynamic> toMap();
  T convertFromInfinityScrollFilter(Set<InfinityScrollFilter> infinityScrollFilters);

  Set<InfinityScrollFilter> convertToInfinityScrollFilters();
}
