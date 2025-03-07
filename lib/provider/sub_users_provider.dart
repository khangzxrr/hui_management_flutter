import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/filters/subuser_filter.dart';
import 'package:hui_management/model/infinity_scroll_filter_model.dart';
import 'package:hui_management/model/sub_user_model.dart';
import 'package:hui_management/provider/abstract_provider/paginated_provider.dart';
import 'package:hui_management/service/user_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SubUsersProvider extends PaginatedProvider<SubUserModel> with ChangeNotifier {
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
    items.add(user);

    notifyListeners();
  }

  @override
  TaskEither<String, void> fetchData(int pageIndex, int pageSize, Set<InfinityScrollFilter> additionalFilters) => TaskEither.tryCatch(
        () async {
          final filter = SubUserFilter().convertFromInfinityScrollFilter(additionalFilters);

          final users = await GetIt.I<UserService>().getAll(pageIndex, pageSize, filter);
          items.addAll(users);

          if (users.length < pageIndex) {
            pagingState = PagingState<int, SubUserModel>(itemList: items);
          } else {
            pagingState = PagingState<int, SubUserModel>(nextPageKey: pageIndex + 1, itemList: items);
          }

          notifyListeners();
        },
        (error, stackTrace) => error.toString(),
      );
      
        @override
        TaskEither<String, void> refreshSingleItem(int itemId) {
          // TODO: implement refreshSingleItem
          throw UnimplementedError();
        }
}
