import 'package:fpdart/fpdart.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../helper/constants.dart';

abstract class PaginatedProvider<T> {
  PagingState<int, T> pagingState = const PagingState();
  List<T> items = List.empty(growable: true);
  String searchTerm = '';
  Set<InfinityScrollFilter> previousFilters = {};

  TaskEither<String, void> refreshPagingTaskEither({Set<InfinityScrollFilter>? newFilters}) => TaskEither.tryCatch(
        () async => await refreshPagingState(newFilters ?? previousFilters),
        (error, stackTrace) => error.toString(),
      );

  Future<void> refreshPagingState(Set<InfinityScrollFilter> additionalFilters, {String newSearchTerm = ''}) async {
    searchTerm = newSearchTerm;

    previousFilters.clear();
    previousFilters.addAll(additionalFilters);

    items.clear();
    await fetchData(0, Constants.pageSize, searchTerm, additionalFilters).run();
  }

  TaskEither<String, void> fetchData(int pageIndex, int pageSize, String searchTerm, Set<InfinityScrollFilter> additionalFilters);
}
