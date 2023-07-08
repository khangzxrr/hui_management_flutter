import 'package:flutter/material.dart';
import 'package:hui_management/model/user_model.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> users = [];

  void addUsers(List<UserModel> users) {
    this.users.addAll(users);

    notifyListeners();
  }

  void removeUser(UserModel user) {
    users.remove(user);

    notifyListeners();
  }

  void updateUser(UserModel user) {
    users.removeWhere((u) => u.id == user.id);

    addUser(user);
  }

  void addUser(UserModel user) {
    users.add(user);

    notifyListeners();
  }
}
