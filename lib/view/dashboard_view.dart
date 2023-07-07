import 'package:flutter/material.dart';
import 'package:hui_management/helper/mocking.dart';
import 'package:hui_management/view/funds_view.dart';
import 'package:hui_management/view/members_view.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isWideScreen = MediaQuery.of(context).size.width >= 1080;

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Màn hình chính'),
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
                  //mocking login success
                  if (MockingData.isTesting) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MembersWidget(),
                      ),
                    );
                  }
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
