import 'package:fpdart/fpdart.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class PaginatedProvider<T> {
  PagingState<int, T> pagingState = const PagingState();

  Future<void> refreshPagingState([String? newSearchTerm]);

  TaskEither<String, void> fetchData(int pageIndex, int pageSize, String searchTerm);
}
