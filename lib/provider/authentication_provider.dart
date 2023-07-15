import 'package:flutter/material.dart';
import 'package:hui_management/model/authentication_model.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel? model;

  void setAuthentication(AuthenticationModel model) {
    this.model = model;

    notifyListeners();
  }
}
