import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:hui_management/service/user_service.dart';

class SubUsersProvider with ChangeNotifier {
  List<SubUserModel> subUsers = [];

  TaskEither<String, List<SubUserModel>> fetchAndFilterUsers({
    bool filterByAnyPayment = false,
    bool getFundRatio = false,
    bool filterByNotFinishedPayment = false,
  }) =>
      TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll(
          filterByAnyPayment: filterByAnyPayment,
          filterByNotFinishedPayment: filterByNotFinishedPayment,
          getFundRatio: getFundRatio,
        );

        return users;
      }, (error, stackTrace) => error.toString());

  TaskEither<String, List<UserWithPaymentReport>> getAllWithPaymentReport() => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAllWithPaymentReport();

        return users;
      }, (error, stackTrace) => error.toString());

  TaskEither<String, void> getAllUsers() => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll();
        this.subUsers = users;

        notifyListeners();
      }, (error, stackTrace) => error.toString());

  TaskEither<String, SubUserModel> createUser(SubUserModel user) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().createNew(user),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> removeUser(int userId) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().delete(userId),
        (error, stackTrace) => error.toString(),
      );

  TaskEither<String, void> updateUser(SubUserModel user) => TaskEither.tryCatch(
        () async => await GetIt.I<UserService>().update(user),
        (error, stackTrace) => error.toString(),
      );

  void addUser(SubUserModel user) {
    subUsers.add(user);

    notifyListeners();
  }
}
