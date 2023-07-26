import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/model/authentication_model.dart';
import 'package:hui_management/model/user_model.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/view/member/member_edit.dart';
import 'package:provider/provider.dart';

import '../helper/dialog.dart';

class DashboardWidget extends StatelessWidget {
  static const routeName = "/dashboard";

  final getIt = GetIt.instance;

  DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width >= 1080;

    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    final generalFundProvider = Provider.of<GeneralFundProvider>(context);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Xin chào ${authenticationProvider.model.user.name}'),

        actions: [
          //setting icon button
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => MemberEditWidget(
                    isCreateNew: false,
                    user: authenticationProvider.model.user,
                  ),
                ),
              )
                  .then((value) {
                if (value != null) {
                  final newAuthenModel = AuthenticationModel(token: authenticationProvider.model.token, user: value as UserModel);
                  authenticationProvider.setAuthentication(newAuthenModel);
                  //update user info
                }
              });
            },
            icon: const Icon(Icons.settings),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed('/');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Flex(
          crossAxisAlignment: isWideScreen ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          direction: isWideScreen ? Axis.horizontal : Axis.vertical,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/members');
                },
                child: const Text('Quản lí người dùng')),
            const SizedBox(width: 30, height: 30),
            ElevatedButton(
                onPressed: () {
                  generalFundProvider
                      .fetchFunds()
                      .match(
                        (l) => log(l),
                        (r) => Navigator.of(context).pushNamed('/funds'),
                      )
                      .run();
                },
                child: const Text('Quản lí dây hụi')),
            const SizedBox(
              width: 30,
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                usersProvider.fetchAndFilterUsers(filterByAnyPayment: true).match((l) {
                  log(l);
                  DialogHelper.showSnackBar(context, 'Có lỗi xảy ra khi lấy danh sách thành viên: $l');
                }, (r) {
                  Navigator.of(context).pushNamed('/funds/payments', arguments: r);
                }).run();
              },
              child: const Text('Quản lí thanh toán'),
            )
          ],
        ),
      ),
    );
  }
}
