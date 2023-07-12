import 'package:flutter/material.dart';
import 'package:hui_management/model/general_fund_model.dart';

class GeneralFundProvider with ChangeNotifier {
  List<GeneralFundModel> _funds = [];

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

  List<GeneralFundModel> getFunds() {
    return _funds;
  }
}
