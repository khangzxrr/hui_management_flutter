import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view/dashboard_view.dart';
import '../view/login_view.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: DashboardRoute.page),
      ];
}
