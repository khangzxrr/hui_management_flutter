import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubUserWithPaymentReportProvider extends PaginatedProvider<SubUserWithPaymentReport> with ChangeNotifier {
  @override
  TaskEither<String, void> fetchData(int pageIndex, int pageSize, Set<InfinityScrollFilter> additionalFilters) => TaskEither.tryCatch(
        () async {
          final filter = SubUserFilter().convertFromInfinityScrollFilter(additionalFilters);

          filter.atLeastOnePayment = true; //additional filter

          final users = await GetIt.I<UserService>().getAllWithPaymentReport(pageIndex, pageSize, filter);
          items.addAll(users);
          //this.searchTerm = searchTerm;

          if (users.length < pageIndex) {
            pagingState = PagingState<int, SubUserWithPaymentReport>(itemList: items);
          } else {
            pagingState = PagingState<int, SubUserWithPaymentReport>(nextPageKey: pageIndex + 1, itemList: items);
          }

          notifyListeners();
        },
        (error, stackTrace) => error.toString(),
      );
}
