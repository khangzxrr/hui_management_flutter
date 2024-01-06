import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../model/infinity_scroll_filter_model.dart';

class InfinityScrollWidget<T> extends StatefulWidget {
  final PaginatedProvider<T> paginatedProvider;
  final Set<InfinityScrollFilter> filters;

  final Widget Function(T) widgetItemFactory;

  const InfinityScrollWidget({
    super.key,
    required this.paginatedProvider,
    required this.widgetItemFactory,
    required this.filters,
  });

  @override
  State<InfinityScrollWidget<T>> createState() => _InfinityScrollWidgetState<T>();
}

class _InfinityScrollWidgetState<T> extends State<InfinityScrollWidget<T>> with AfterLayoutMixin<InfinityScrollWidget<T>> {
  String _searchTerm = '';
  Set<InfinityScrollFilter> selectedFilters = {};

  final PagingController<int, T> pagingController = PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    print(selectedFilters);

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
                    widget.paginatedProvider.refreshPagingState(selectedFilters, newSearchTerm: _searchTerm);
                  });
                },
                decoration: const InputDecoration(labelText: 'Tìm kiếm ở đây'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Wrap(
                spacing: 4.0,
                children: widget.filters
                    .map(
                      (filter) => FilterChip(
                        label: Text(filter.name),
                        selected: selectedFilters.any((f) => f.value == filter.value),
                        onSelected: (selected) async {
                          //because refreshPagingState cause widget to reload
                          //that is why we dont really need to call setState for filters
                          if (selected) {
                            selectedFilters.add(filter);
                          } else {
                            selectedFilters.removeWhere((f) => f.value == filter.value);
                          }

                          await widget.paginatedProvider.refreshPagingState(selectedFilters, newSearchTerm: _searchTerm);
                        },
                      ),
                    )
                    .toList(),
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
      onRefresh: () async => await widget.paginatedProvider.refreshPagingState(selectedFilters, newSearchTerm: _searchTerm),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    pagingController.addPageRequestListener((pageKey) async {
      await widget.paginatedProvider.fetchData(pageKey, Constants.pageSize, _searchTerm, selectedFilters).run();
    });

    final result = await widget.paginatedProvider.fetchData(0, Constants.pageSize, _searchTerm, selectedFilters).run();

    result.match((l) {
      print(l);
      final retrySnackBar = SnackBar(
        content: const Text('Có lỗi xảy ra khi tải dữ liệu'),
        action: SnackBarAction(
          label: 'Thử lại',
          onPressed: () async {
            await widget.paginatedProvider.fetchData(0, Constants.pageSize, _searchTerm, selectedFilters).run();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(retrySnackBar);
    }, (r) => print('OK'));
  }
}
