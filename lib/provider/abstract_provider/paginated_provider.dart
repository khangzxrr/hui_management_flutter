import 'package:fpdart/fpdart.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../helper/constants.dart';

abstract class PaginatedProvider<T> {
  PagingState<int, T> pagingState = const PagingState();
  List<T> items = List.empty(growable: true);
  String searchTerm = '';
  Set<InfinityScrollFilter> previousFilters = {};

  TaskEither<String, void> refreshPagingTaskEither() => TaskEither.tryCatch(() async => await refreshPagingState(previousFilters), (error, stackTrace) => error.toString());

  Set<String> getFilterValues(Set<InfinityScrollFilter> filters) => filters.map((f) => f.value).toSet();

  Future<void> refreshPagingState(Set<InfinityScrollFilter> additionalFilters, {String newSearchTerm = ''}) async {
    searchTerm = newSearchTerm;

    previousFilters.clear();
    previousFilters.addAll(additionalFilters);

    items.clear();
    await fetchData(0, Constants.pageSize, searchTerm, additionalFilters).run();
  }

  TaskEither<String, void> fetchData(int pageIndex, int pageSize, String searchTerm, Set<InfinityScrollFilter> additionalFilters);
}
