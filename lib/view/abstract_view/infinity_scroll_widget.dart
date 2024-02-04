import 'dart:async';
import 'dart:developer' as developer;
import 'package:after_layout/after_layout.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/helper/dialog.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../model/infinity_scroll_filter_model.dart';

class InfinityScrollWidget<T> extends StatefulWidget {
  final PaginatedProvider<T> paginatedProvider;
  final Set<InfinityScrollFilter> filters;
  final Set<InfinityScrollFilter> alwaysOnFilters;

  final Widget Function(T) widgetItemFactory;

  const InfinityScrollWidget({
    super.key,
    required this.paginatedProvider,
    required this.widgetItemFactory,
    required this.filters,
    this.alwaysOnFilters = const {},
  });

  @override
  State<InfinityScrollWidget<T>> createState() => _InfinityScrollWidgetState<T>();
}

class _InfinityScrollWidgetState<T> extends State<InfinityScrollWidget<T>> with AfterLayoutMixin<InfinityScrollWidget<T>> {
  Set<InfinityScrollFilter> selectedFilters = {};

  final PagingController<int, T> pagingController = PagingController(firstPageKey: 0);

  @override
  Widget build(BuildContext context) {
    selectedFilters.addAll(widget.alwaysOnFilters);

    developer.log(selectedFilters.toString(), name: 'infinity.scroll.widget.build');

    return RefreshIndicator(
      child: CustomScrollView(
        slivers: <Widget>[
          ...widget.filters
              .where((f) => f.textFilter)
              .map(
                (f) => SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (String searchTerm) {
                        EasyDebounce.debounce(f.name, const Duration(milliseconds: 500), () async {
                          selectedFilters.removeWhere((selectedFilter) => selectedFilter.name == f.name);

                          f.value = searchTerm;
                          selectedFilters.add(f);

                          widget.paginatedProvider.refreshPagingState(selectedFilters);
                        });
                      },
                      decoration: InputDecoration(labelText: f.label),
                    ),
                  ),
                ),
              )
              .toList(),
          SliverToBoxAdapter(
            child: Center(
              child: Wrap(
                spacing: 4.0,
                children: widget.filters
                    .where((f) => !f.textFilter && f.isShow)
                    .map(
                      (filter) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: FilterChip(
                          label: Text(filter.label),
                          selected: selectedFilters.any((f) => f.name == filter.name),
                          onSelected: (selected) async {
                            //because refreshPagingState cause widget to reload
                            //that is why we dont really need to call setState for filters

                            if (selected) {
                              selectedFilters.add(filter);
                            } else {
                              selectedFilters.removeWhere((f) => f.name == filter.name);
                            }

                            developer.log(
                              'selected filters count: ${selectedFilters.length}',
                              name: 'infinity.scroll.widget.filterchip.onselect',
                            );

                            await widget.paginatedProvider
                                .refreshPagingTaskEither(newFilters: selectedFilters)
                                .match(
                                  (l) => DialogHelper.showSnackBar(context, 'Có lỗi khi lấy dữ liệu'),
                                  (r) {},
                                )
                                .run();
                          },
                        ),
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
      onRefresh: () async => await widget.paginatedProvider.refreshPagingState(selectedFilters),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    pagingController.addPageRequestListener((pageKey) async {
      await widget.paginatedProvider.fetchData(pageKey, Constants.pageSize, selectedFilters).run();
    });

    final result = await widget.paginatedProvider.fetchData(0, Constants.pageSize, selectedFilters).run();

    result.match((l) {
      developer.log(l, name: 'infinity.scroll.widget');

      final retrySnackBar = SnackBar(
        content: const Text('Có lỗi xảy ra khi tải dữ liệu'),
        action: SnackBarAction(
          label: 'Thử lại',
          onPressed: () async {
            await widget.paginatedProvider.fetchData(0, Constants.pageSize, selectedFilters).run();
          },
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(retrySnackBar);
    }, (r) {});
  }
}
