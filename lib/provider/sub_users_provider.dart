import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/model/user_with_payment_report.dart';
import 'package:hui_management/service/user_service.dart';

enum SubUserFilter { filterByAnyPayment, getFundRatio, filterByNotFinishedPayment, filterByContainToDayPayment }

class SubUsersProvider with ChangeNotifier {
  bool loading = false;

  List<SubUserModel> subUsers = [];
  List<UserWithPaymentReport> subUsersWithPaymentReport = [];

  TaskEither<String, List<SubUserModel>> fetchAndFilterUsers(Set<SubUserFilter> filters) => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll(filters);

        return users;
      }, (error, stackTrace) => error.toString());

  void setLoading(bool value) {
    loading = value;

    notifyListeners();
  }

  TaskEither<String, List<UserWithPaymentReport>> getAllWithPaymentReport({
    required Set<SubUserFilter> filters,
    required bool usingLoadingIdicator,
  }) =>
      TaskEither.tryCatch(() async {
        if (usingLoadingIdicator) setLoading(true);

        final users = await GetIt.I<UserService>().getAllWithPaymentReport(filters);

        subUsersWithPaymentReport = users;

        if (usingLoadingIdicator) {
          setLoading(false);
        } else {
          notifyListeners();
        }

        return users;
      }, (error, stackTrace) => error.toString());

  TaskEither<String, void> getAllUsers() => TaskEither.tryCatch(() async {
        setLoading(true);
        final users = await GetIt.I<UserService>().getAll({});
        subUsers = users;

        setLoading(false);
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
