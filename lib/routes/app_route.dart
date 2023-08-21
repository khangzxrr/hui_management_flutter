import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hui_management/view/fund/fund_report.dart';

import '../model/fund_member.dart';
import '../model/fund_session_model.dart';
import '../model/general_fund_model.dart';
import '../model/payment_model.dart';
import '../model/sub_user_model.dart';
import '../model/user_with_payment_report.dart';
import '../view/dashboard_info.dart';
import '../view/dashboard_view.dart';
import '../view/fund/fund_detail.dart';
import '../view/fund/fund_edit.dart';
import '../view/fund/fund_members_view.dart';
import '../view/fund/fund_report_pdf_view.dart';
import '../view/fund/funds_view.dart';
import '../view/fund_session/fund_normal_session_export_pdf_view.dart';
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
import '../view_models/fund_report_to_pdf_vm.dart';
import 'auth_guard.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: DashboardRoute.page,
          guards: [AuthGuard()],
          children: [
            AutoRoute(page: DashboardInfoRoute.page, guards: [AuthGuard()]),
            AutoRoute(page: MembersRoute.page, guards: [AuthGuard()]),
            AutoRoute(page: MultipleFundsRoute.page, guards: [AuthGuard()]),
            AutoRoute(page: MultiplePaymentMembersRoute.page, guards: [AuthGuard()]),
            AutoRoute(page: MemberReportRoute.page, guards: [AuthGuard()]),
          ],
        ),
        AutoRoute(page: MemberEditRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FundMembersRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FundEditRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FundDetailRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FundSessionListRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: CreateSessionSelectMemberRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: CreateSessionEnterInfoRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: SessionDetailRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: PaymentListOfUserRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: PaycheckRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: PaymentDetailRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: FundReportRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: PdfExportReviewRoute.page, guards: [AuthGuard()]),
     
      ];
}
