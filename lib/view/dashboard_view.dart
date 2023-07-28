import 'dart:async';
import 'dart:developer';

import 'package:after_layout/after_layout.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
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
import '../routes/app_route.dart';
import '../service/image_service.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AfterLayoutMixin<DashboardScreen> {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: true); //must not listen to avoid infinite loop

    return Scaffold(
      appBar: AppBar(
        // // Here we take the value from the MyHomePage object that was created by
        // // the App.build method, and use it to set our appbar title.
        title: Text('Menu quản lí hụi'),

        actions: [
          //setting icon button
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => MemberEditWidget(
                    isCreateNew: false,
                    user: authenticationProvider.model!.user,
                  ),
                ),
              )
                  .then((value) {
                if (value != null) {
                  final newAuthenModel = AuthenticationModel(token: authenticationProvider.model!.token, user: value as UserModel);
                  authenticationProvider.setAuthentication(newAuthenModel);

                  Navigator.of(context).popAndPushNamed('/dashboard');
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
              authenticationProvider.clearAuthentication();
              //context.router.navigate(LoginRoute());
              if (context.router.canNavigateBack) {
                context.router.navigate(LoginRoute());
              } else {
                context.router.popUntilRoot();
              }
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: (authenticationProvider.model != null)
          ? const DashboardInfo()
          : ElevatedButton(
              onPressed: () {
                if (context.router.canNavigateBack) {
                  context.router.navigate(LoginRoute());
                } else {
                  context.router.popUntilRoot();
                }
              },
              child: const Text('Bạn không có quyền xem trang này, nhấn vào đây để đăng nhập lại'),
            ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false); //must not listen to avoid infinite loop

    if (authenticationProvider.model == null) {
      context.router.navigate(LoginRoute());
    }
  }
}

class DashboardInfo extends StatelessWidget {
  const DashboardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final authenticationProvider = Provider.of<AuthenticationProvider>(context, listen: false); //must not listen to avoid infinite loop

    final usersProvider = Provider.of<UsersProvider>(context, listen: false);

    final generalFundProvider = Provider.of<GeneralFundProvider>(context, listen: false);

    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        //must check before using model (it can be null exception)
        FutureBuilder(
          future: GetIt.I<ImageService>().getImagePathFromFireStorage(authenticationProvider.model!.user.imageUrl),
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
          authenticationProvider.model!.user.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.user.address,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          authenticationProvider.model!.user.phonenumber,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5, width: 5),
        Text(
          textAlign: TextAlign.center,
          '${authenticationProvider.model!.user.bankname} - ${authenticationProvider.model!.user.banknumber}',
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
    );
  }
}
