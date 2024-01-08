import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/general_fund_filter.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class GeneralFundProvider extends PaginatedProvider<GeneralFundModel> with ChangeNotifier {
  GeneralFundModel getGeneralFundById(int id) {
    return items.where((f) => f.id == id).first;
  }

  void updateGeneralFundMemberCount(int id, int membersCountOffset) {
    final fund = items.where((f) => f.id == id).first;
    fund.membersCount += membersCountOffset;

    updateFund(fund);
  }

  void updateFund(GeneralFundModel fund) {
    var index = items.lastIndexWhere((element) => element.id == fund.id);
    items[index] = fund;

    notifyListeners();
  }

  void removeFund(GeneralFundModel fund) {
    items.removeWhere((element) => element.id == fund.id);

    notifyListeners();
  }

  void addFund(GeneralFundModel fund) {
    items.add(fund);

    notifyListeners();
  }

  void updateSessionCount(int fundId, int sessionCountOffset) {
    final fund = items.where((f) => f.id == fundId).first;
    fund.sessionsCount += sessionCountOffset;

    updateFund(fund);
  }

  @override
  TaskEither<String, void> fetchData(int pageIndex, int pageSize, Set<InfinityScrollFilter> additionalFilters) => TaskEither.tryCatch(() async {
        var filter = GeneralFundFilter().convertFromInfinityScrollFilter(additionalFilters);

        final funds = await GetIt.I<FundService>().getAll(pageIndex, pageSize, filter);

        items.addAll(funds);

        if (funds.length < pageSize) {
          pagingState = PagingState<int, GeneralFundModel>(itemList: items);
        } else {
          pagingState = PagingState<int, GeneralFundModel>(nextPageKey: pageIndex + 1, itemList: items);
        }

        notifyListeners();
      }, (error, stackTrace) => error.toString());
}
