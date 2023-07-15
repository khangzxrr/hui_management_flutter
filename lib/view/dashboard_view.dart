import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/service/fund_service.dart';
import 'package:provider/provider.dart';

class DashboardWidget extends StatelessWidget {
  final getIt = GetIt.instance;

  DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width >= 1080;

    final authenticationProvider = Provider.of<AuthenticationProvider>(context);
    final usersProvider = Provider.of<UsersProvider>(context);

    final fundProvier = Provider.of<GeneralFundProvider>(context);

    if (authenticationProvider.model == null) {
      Navigator.of(context).popAndPushNamed('/login');
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Xin chào ${authenticationProvider.model!.name}'),
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
                child: const Text('Danh sách người dùng')),
            const SizedBox(width: 30, height: 30),
            ElevatedButton(
                onPressed: () {
                  getIt<FundService>().getAll().match(
                    (err) => log(err),
                    (funds) {
                      fundProvier.setFunds(funds);

                      Navigator.of(context).pushNamed('/funds');
                    },
                  ).run();
                },
                child: const Text('Danh sách dây hụi')),
          ],
        ),
      ),
    );
  }
}
