import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/authentication_model.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel? model = null;

  void setAuthentication(AuthenticationModel? model) {
    this.model = model;

    notifyListeners();
  }
}
