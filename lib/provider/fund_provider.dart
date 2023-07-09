import 'package:flutter/material.dart';
import 'package:hui_management/model/fund_model.dart';

class FundProvider with ChangeNotifier {
  List<Fund> _funds = [];

  void setFunds(List<Fund> funds) {
    _funds = funds;

    notifyListeners();
  }

  void updateFund(Fund fund) {
    var index = _funds.lastIndexWhere((element) => element.id == fund.id);
    _funds[index] = fund;

    notifyListeners();
  }

  void removeFund(Fund fund) {
    _funds.removeWhere((element) => element.id == fund.id);

    notifyListeners();
  }

  void addFund(Fund fund) {
    _funds.add(fund);

    notifyListeners();
  }

  List<Fund> getFunds() {
    return _funds;
  }
}
