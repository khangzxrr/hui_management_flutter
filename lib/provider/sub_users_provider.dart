import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/helper/constants.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/model/sub_user_with_payment_report.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum SubUserFilter { filterByAnyPayment, getFundRatio, filterByNotFinishedPayment, filterByContainToDayPayment }

class SubUsersProvider extends PaginatedProvider<SubUserModel> with ChangeNotifier {
  final List<SubUserModel> _subUsers = [];
  String _searchTerm = '';
  List<SubUserWithPaymentReport> subUsersWithPaymentReport = [];

  // TaskEither<String, List<SubUserModel>> fetchAndFilterUsers(Set<SubUserFilter> filters) => TaskEither.tryCatch(() async {
  //       final users = await GetIt.I<UserService>().getAll(filters);

  //       return users;
  //     }, (error, stackTrace) => error.toString());

  TaskEither<String, List<SubUserWithPaymentReport>> getAllWithPaymentReport({required Set<SubUserFilter> filters, required bool usingLoadingIdicator}) => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAllWithPaymentReport(filters);

        subUsersWithPaymentReport = users;

        return users;
      }, (error, stackTrace) => error.toString());

  TaskEither<String, void> fetchSubUsers(int pageIndex, int pageSize, String searchTerm) => TaskEither.tryCatch(() async {
        final users = await GetIt.I<UserService>().getAll(pageIndex, pageSize, searchTerm, {});
        _subUsers.addAll(users);

        if (users.length < pageIndex) {
          pagingState = PagingState<int, SubUserModel>(itemList: _subUsers);
        } else {
          pagingState = PagingState<int, SubUserModel>(nextPageKey: pageIndex + 1, itemList: users);
        }

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
    _subUsers.add(user);

    notifyListeners();
  }

  @override
  Future<void> refreshPagingState([String? newSearchTerm]) async {
    if (newSearchTerm != null) {
      _searchTerm = newSearchTerm;
    }

    _subUsers.clear();
    await fetchSubUsers(0, Constants.pageSize, _searchTerm).run();
  }

  @override
  TaskEither<String, void> fetchData(int pageIndex, int pageSize, String searchTerm) => TaskEither.tryCatch(
        () async {
          final users = await GetIt.I<UserService>().getAll(pageIndex, pageSize, searchTerm, {});
          _subUsers.addAll(users);
          _searchTerm = searchTerm;

          if (users.length < pageIndex) {
            pagingState = PagingState<int, SubUserModel>(itemList: _subUsers);
          } else {
            pagingState = PagingState<int, SubUserModel>(nextPageKey: pageIndex + 1, itemList: _subUsers);
          }

          notifyListeners();
        },
        (error, stackTrace) => error.toString(),
      );
}
