import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:hui_management/provider/fund_provider.dart';
import 'package:hui_management/provider/general_fund_provider.dart';
import 'package:hui_management/provider/payment_provider.dart';
import 'package:hui_management/provider/user_report_provider.dart';
import 'package:hui_management/provider/sub_users_provider.dart';
import 'package:hui_management/routes/app_route.dart';
import 'package:hui_management/service/setup_service.dart';

import 'package:hui_management/view/login_view.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SetupService.setup();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
      ChangeNotifierProvider(create: (context) => SubUsersProvider()),
      ChangeNotifierProvider(create: (context) => GeneralFundProvider()),
      ChangeNotifierProvider(create: (context) => FundProvider()),
      ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ChangeNotifierProvider(create: (context) => UserReportProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appRouter = AppRouter();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Quản lí hụi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter.config(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
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
