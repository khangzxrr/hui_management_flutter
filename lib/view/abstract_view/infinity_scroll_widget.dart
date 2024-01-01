import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfinityScrollWidget<T> extends StatefulWidget {
  final PaginatedProvider<T> paginatedProvider;

  final Widget Function(T) widgetItemFactory;

  const InfinityScrollWidget({
    super.key,
    required this.paginatedProvider,
    required this.widgetItemFactory,
  });

  @override
  State<InfinityScrollWidget<T>> createState() => _InfinityScrollWidgetState<T>();
}

class _InfinityScrollWidgetState<T> extends State<InfinityScrollWidget<T>> with AfterLayoutMixin<InfinityScrollWidget<T>> {
  String _searchTerm = '';

  final PagingController<int, T> pagingController = PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (String searchTerm) {
                  EasyDebounce.debounce('infinity_search', const Duration(milliseconds: 500), () {
                    _searchTerm = searchTerm;
                    widget.paginatedProvider.refreshPagingState(_searchTerm);
                  });
                },
                decoration: const InputDecoration(labelText: 'Tìm kiếm ở đây'),
              ),
            ),
          ),
          PagedSliverList(
            pagingController: pagingController..value = widget.paginatedProvider.pagingState,
            builderDelegate: PagedChildBuilderDelegate<T>(
              itemBuilder: (context, item, index) => widget.widgetItemFactory(item),
            ),
          ),
        ],
      ),
      onRefresh: () => widget.paginatedProvider.refreshPagingState(),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    pagingController.addPageRequestListener((pageKey) async {
      await widget.paginatedProvider.fetchData(pageKey, Constants.pageSize, _searchTerm).run();
    });

    await widget.paginatedProvider.fetchData(0, Constants.pageSize, _searchTerm).run();
  }
}
