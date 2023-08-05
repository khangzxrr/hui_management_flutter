import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/fund_member.dart';
import '../model/fund_session_model.dart';
import '../model/general_fund_model.dart';
import '../model/payment_model.dart';
import '../model/user_model.dart';
import '../model/user_report_model.dart';
import '../view/dashboard_view.dart';
import '../view/fund/fund_detail.dart';
import '../view/fund/fund_edit.dart';
import '../view/fund/fund_members_view.dart';
import '../view/fund/funds_view.dart';
import '../view/fund_session/fund_sessions_view.dart';
import '../view/fund_session/session_create_enter_info.dart';
import '../view/fund_session/session_create_select_member.dart';
import '../view/fund_session/session_detail_view.dart';
import '../view/login_view.dart';
import '../view/member/member_edit.dart';
import '../view/member/members_report.dart';
import '../view/member/members_view.dart';
import '../view/payments/payment_detail_table_view.dart';
import '../view/payments/payment_paycheck_view.dart';
import '../view/payments/payment_summaries_view.dart';
import '../view/payments/payments_members_view.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: DashboardRoute.page),
        AutoRoute(page: MembersRoute.page),
        AutoRoute(page: MultipleFundsRoute.page),
        AutoRoute(page: MultiplePaymentMembersRoute.page),
        AutoRoute(page: MemberEditRoute.page),
        AutoRoute(page: FundMembersRoute.page),
        AutoRoute(page: FundEditRoute.page),
        AutoRoute(page: FundDetailRoute.page),
        AutoRoute(page: FundSessionListRoute.page),
        AutoRoute(page: CreateSessionSelectMemberRoute.page),
        AutoRoute(page: CreateSessionEnterInfoRoute.page),
        AutoRoute(page: SessionDetailRoute.page),
        AutoRoute(page: PaymentListOfUserRoute.page),
        AutoRoute(page: PaycheckRoute.page),
        AutoRoute(page: PaymentDetailRoute.page),
        AutoRoute(page: MemberReportRoute.page),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();

    // if (authenticationProvider.model != null) {
    //   resolver.next();
    // } else {
    //   resolver.redirect(LoginRoute());
    // }
  }
}
