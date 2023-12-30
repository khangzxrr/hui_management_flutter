import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../helper/constants.dart';

class GeneralFundProvider with ChangeNotifier {
  List<GeneralFundModel> _funds = [];

  PagingState<int, GeneralFundModel> _pagingState = const PagingState<int, GeneralFundModel>(nextPageKey: 0);

  void setFunds(List<GeneralFundModel> funds) {
    _funds = funds;

    notifyListeners();
  }

  GeneralFundModel getGeneralFundById(int id) {
    return getFunds.where((f) => f.id == id).first;
  }

  void updateGeneralFundMemberCount(int id, int membersCountOffset) {
    final fund = _funds.where((f) => f.id == id).first;
    fund.membersCount += membersCountOffset;

    updateFund(fund);
  }

  void updateFund(GeneralFundModel fund) {
    var index = _funds.lastIndexWhere((element) => element.id == fund.id);
    _funds[index] = fund;

    notifyListeners();
  }

  void removeFund(GeneralFundModel fund) {
    _funds.removeWhere((element) => element.id == fund.id);

    notifyListeners();
  }

  void addFund(GeneralFundModel fund) {
    _funds.add(fund);

    notifyListeners();
  }

  TaskEither<String, List<GeneralFundModel>> fetchFunds(int pageIndex, int pageSize) => TaskEither.tryCatch(() async {
        final funds = await GetIt.I<FundService>().getAll(pageIndex, pageSize);

        _funds.addAll(funds);

        if (funds.length < pageSize) {
          _pagingState = PagingState<int, GeneralFundModel>(itemList: _funds);
        } else {
          _pagingState = PagingState<int, GeneralFundModel>(nextPageKey: pageIndex + 1, itemList: funds);
        }

        notifyListeners();

        return funds;
      }, (error, stackTrace) => error.toString());

  List<GeneralFundModel> get getFunds => _funds;

  PagingState<int, GeneralFundModel> get pagingState => _pagingState;

  Future<void> refreshPagingState() async {
    _funds.clear();
    await fetchFunds(0, Constants.pageSize).run();
  }
}
