import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../helper/constants.dart';

abstract class PaginatedProvider<T> {
  PagingState<int, T> pagingState = const PagingState();
  List<T> items = List.empty(growable: true);
  String searchTerm = '';

  TaskEither<String, void> refreshPagingTaskEither() => TaskEither.tryCatch(() async => await refreshPagingState(), (error, stackTrace) => error.toString());

  Future<void> refreshPagingState([String? newSearchTerm]) async {
    if (newSearchTerm != null) {
      searchTerm = newSearchTerm;
    }

    items.clear();
    await fetchData(0, Constants.pageSize, searchTerm).run();
  }

  TaskEither<String, void> fetchData(int pageIndex, int pageSize, String searchTerm);
}
