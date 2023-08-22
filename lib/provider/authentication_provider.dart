import 'package:flutter/material.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel? model;
  void setAuthentication(AuthenticationModel model) {
    this.model = model;

    notifyListeners();
  }

  Future<String> getPreviousPhonenumber() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('phonenumber') ?? '';
  }

  Future<void> setPreviousPhonenumber(String phonenumber) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('phonenumber', phonenumber);
  }

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
