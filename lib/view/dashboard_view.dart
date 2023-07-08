import 'package:flutter/material.dart';
import 'package:hui_management/helper/mocking.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/view/funds_view.dart';
import 'package:hui_management/view/members_view.dart';
import 'package:provider/provider.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width >= 1080;

    final authenticationProvider = Provider.of<AuthenticationProvider>(context);

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
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MembersWidget(),
                    ),
                  );
                },
                child: const Text('Danh sách người dùng')),
            const SizedBox(width: 30, height: 30),
            ElevatedButton(
                onPressed: () async {
                  //mocking login success
                  if (MockingData.isTesting) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FundsWidget(),
                      ),
                    );
                  }
                },
                child: const Text('Danh sách dây hụi')),
          ],
        ),
      ),
    );
  }
}
