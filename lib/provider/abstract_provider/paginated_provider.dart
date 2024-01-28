import 'package:fpdart/fpdart.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../helper/constants.dart';

abstract class PaginatedProvider<T> {
  PagingState<int, T> pagingState = const PagingState();
  List<T> items = List.empty(growable: true);
  Set<InfinityScrollFilter> previousFilters = {};

  TaskEither<String, void> refreshPagingTaskEither({Set<InfinityScrollFilter>? newFilters}) => TaskEither.tryCatch(
        () async => await refreshPagingState(newFilters ?? previousFilters),
        (error, stackTrace) => error.toString(),
      );

  Future<void> refreshPagingState(Set<InfinityScrollFilter> additionalFilters) async {
    previousFilters.clear();
    previousFilters.addAll(additionalFilters);

    items.clear();
    await fetchData(0, Constants.pageSize, additionalFilters).run();
  }

  TaskEither<String, void> refreshSingleItem(int itemId);

  TaskEither<String, void> fetchData(int pageIndex, int pageSize, Set<InfinityScrollFilter> additionalFilters);
}
