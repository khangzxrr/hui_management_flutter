import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/service/setup_service.dart';
import 'package:hui_management/view/dashboard_view.dart';

import 'package:hui_management/view/login_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'view/fund/funds_view.dart';
import 'view/member/members_view.dart';
import 'view/payments/payment_summaries_view.dart';
import 'view/payments/payments_members_view.dart';

void main() {
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    FirebaseStorage.instanceFor(app: value);
  });

  SetupService.setup();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (context) => UsersProvider()),
      ChangeNotifierProvider(create: (context) => GeneralFundProvider()),
      ChangeNotifierProvider(create: (context) => FundProvider()),
      ChangeNotifierProvider(create: (context) => PaymentProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lí hụi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => const MyHomePage(title: 'Quản lí hụi'),
        DashboardWidget.routeName: (context) => DashboardWidget(),
        '/members': (context) => const MembersWidget(),
        '/funds': (context) => const FundsWidget(),
        '/funds/payments': (context) => const PaymentMembersViewWidget(),
        '/members/payments': (context) => const PaymentMembersViewWidget(),
        PaymentSummariesWidget.routeName: (context) => const PaymentSummariesWidget(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return LoginWidget();
  }
}
