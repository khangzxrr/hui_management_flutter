import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/provider/user_report_provider.dart';
import 'package:hui_management/provider/users_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/service/setup_service.dart';
import 'package:hui_management/storage/hive_configuration.dart';

import 'package:hui_management/view/login_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  final fireApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseStorage.instanceFor(app: fireApp);

  await HiveConfiguration.setup();
  SetupService.setup();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (context) => UsersProvider()),
      ChangeNotifierProvider(create: (context) => GeneralFundProvider()),
      ChangeNotifierProvider(create: (context) => FundProvider()),
      ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ChangeNotifierProvider(create: (context) => UserReportProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quản lí hụi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter.config(),
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
    return LoginScreen();
  }
}
