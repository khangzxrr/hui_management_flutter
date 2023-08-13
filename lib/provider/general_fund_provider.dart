import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/general_fund_model.dart';
import 'package:hui_management/service/fund_service.dart';

class GeneralFundProvider with ChangeNotifier {
  bool loading = false;
  List<GeneralFundModel> _funds = [];

  void setLoading(bool loading) {
    this.loading = loading;

    notifyListeners();
  }

  void setFunds(List<GeneralFundModel> funds) {
    _funds = funds;

    notifyListeners();
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

  TaskEither<String, List<GeneralFundModel>> fetchFunds() => TaskEither.tryCatch(() async {
        setLoading(true);

        final funds = await GetIt.I<FundService>().getAll();

        setFunds(funds);

        setLoading(false);

        return funds;
      }, (error, stackTrace) => error.toString());

  List<GeneralFundModel> getFunds() {
    return _funds;
  }
}
