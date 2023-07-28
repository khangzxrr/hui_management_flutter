import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../view/dashboard_view.dart';
import '../view/fund/funds_view.dart';
import '../view/login_view.dart';
import '../view/member/member_edit.dart';
import '../view/member/members_view.dart';
import '../view/payments/payments_members_view.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: MembersRoute.page),
        AutoRoute(page: MultipleFundsRoute.page),
        AutoRoute(page: MultiplePaymentMembersRoute.page),
        AutoRoute(page: MemberEditRoute.page),
      ];
}
