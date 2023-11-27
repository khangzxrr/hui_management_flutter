import 'package:flutter/material.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/setup_service.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel? model;
  void setAuthentication(AuthenticationModel model) async {
    this.model = model;

    //setPreviousAuthenticationModel(model);

    SetupService.setupAuthorizeServiced(model.token);
    SetupService.setup();

    notifyListeners();
  }

  // Future<AuthenticationModel?> getPreviousAuthenticationModel() async {
  //   if (model != null) return model;

  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.containsKey('authenticationModel')) {
  //     model = AuthenticationModel.fromJson(jsonDecode(sharedPreferences.getString('authenticationModel')!));

  //     notifyListeners();

  //     return model;
  //   }

  //   return null;
  // }

  // Future<void> setPreviousAuthenticationModel(AuthenticationModel model) async {
  //   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   sharedPreferences.setString('authenticationModel', jsonEncode(model));
  // }

  Future<String> getPreviousPassword() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('password') ?? '';
  }

  Future<void> setPreviousPassword(String password) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('password', password);
  }

  void clearAuthentication() {
    model = null;

    notifyListeners();
  }
}
