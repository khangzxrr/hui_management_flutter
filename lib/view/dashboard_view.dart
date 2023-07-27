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
import '../service/image_service.dart';

class DashboardWidget extends StatelessWidget {
  static const routeName = "/dashboard";

  final getIt = GetIt.instance;

  DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
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
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          FutureBuilder(
            future: GetIt.I<ImageService>().getImagePathFromFireStorage(authenticationProvider.model.user.imageUrl),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: CircleAvatar(
                    radius: 100,
                    foregroundImage: NetworkImage(snapshot.data as String),
                  ),
                );
              } else {
                return const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('images/member.jpg'),
                );
              }
            },
          ),
          const SizedBox(height: 10, width: 10),
          Text(
            textAlign: TextAlign.center,
            authenticationProvider.model.user.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5, width: 5),
          Text(
            textAlign: TextAlign.center,
            authenticationProvider.model.user.address,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 5, width: 5),
          Text(
            textAlign: TextAlign.center,
            authenticationProvider.model.user.phonenumber,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 5, width: 5),
          Text(
            textAlign: TextAlign.center,
            '${authenticationProvider.model.user.bankname} - ${authenticationProvider.model.user.banknumber}',
            style: TextStyle(fontSize: 20, backgroundColor: Colors.red.shade600, color: Colors.white),
          ),
          const SizedBox(height: 10, width: 10),
          ElevatedButton(
              onPressed: () {
                usersProvider.getAllUsers().match((l) {
                  DialogHelper.showSnackBar(context, 'Có lỗi khi lấy danh sách thành viên');
                  Navigator.of(context).pop();
                }, (r) {
                  Navigator.of(context).pushNamed('/members');
                }).run();
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
    );
  }
}
