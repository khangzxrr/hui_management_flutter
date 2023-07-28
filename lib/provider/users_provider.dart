import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/service/user_service.dart';

class UsersProvider with ChangeNotifier {
  List<UserModel> users = [];

  TaskEither<String, List<UserModel>> fetchAndFilterUsers({
    bool filterByAnyPayment = false,
    bool filterByNotFinishedPayment = false,
  }) =>
      TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll(
          filterByAnyPayment: filterByAnyPayment,
          filterByNotFinishedPayment: filterByNotFinishedPayment,
        );

        return users;
      }, (error, stackTrace) => error.toString());

  TaskEither<String, void> getAllUsers() => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll();
        this.users = users;

        notifyListeners();
      }, (error, stackTrace) => error.toString());

  TaskEither<String, UserModel> createUser(UserModel user) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().createNew(user),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> removeUser(int userId) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().delete(userId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> updateUser(UserModel user) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().update(user),
        (error, stackTrace) => error.toString(),
      );

  void addUser(UserModel user) {
    users.add(user);

    notifyListeners();
  }
}
