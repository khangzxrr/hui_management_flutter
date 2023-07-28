import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hui_management/model/authentication_model.dart';

class AuthenticationProvider with ChangeNotifier {
  AuthenticationModel? model;

  final box = Hive.box('authentication');

  void setAuthentication(AuthenticationModel model) {
    this.model = model;

    box.put('model', model);

    notifyListeners();
  }

  void clearAuthentication() {
    box.delete('model');

    model = null;

    notifyListeners();
  }

  AuthenticationModel? loadAuthenticationFromCache() {
    final cachedModel = box.get('model') as AuthenticationModel?;

    if (cachedModel == null) {
      return null;
    }

    print(cachedModel);

    model = cachedModel;
    notifyListeners();

    return model;
  }
}
