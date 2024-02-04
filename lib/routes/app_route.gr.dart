// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_route.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AddCustomBillRoute.name: (routeData) {
      final args = routeData.argsAs<AddCustomBillRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AddCustomBillScreen(
          key: args.key,
          subuser: args.subuser,
        ),
      );
    },
    CreateSessionEnterInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CreateSessionEnterInfoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CreateSessionEnterInfoScreen(
          key: args.key,
          fundMember: args.fundMember,
        ),
      );
    },
    CreateSessionSelectMemberRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateSessionSelectMemberScreen(),
      );
    },
    DashboardInfoRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardInfoScreen(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    EmergencySessionCreateSelectMemberRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EmergencySessionCreateSelectMemberScreen(),
      );
    },
    FinalSettlementForDeadSessionRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FinalSettlementForDeadSessionScreen(),
      );
    },
    FundBelongToSubUserRoute.name: (routeData) {
      final args = routeData.argsAs<FundBelongToSubUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FundBelongToSubUserScreen(
          key: args.key,
          subUserId: args.subUserId,
          subUserName: args.subUserName,
        ),
      );
    },
    FundDetailRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FundDetailScreen(),
      );
    },
    FundEditRoute.name: (routeData) {
      final args = routeData.argsAs<FundEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FundEditScreen(
          key: args.key,
          isNew: args.isNew,
          fund: args.fund,
        ),
      );
    },
    FundMembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FundMembersScreen(),
      );
    },
    FundNormalSessionExportPdfRoute.name: (routeData) {
      final args = routeData.argsAs<FundNormalSessionExportPdfRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FundNormalSessionExportPdfScreen(
          key: args.key,
          takenSessionDetail: args.takenSessionDetail,
          session: args.session,
        ),
      );
    },
    FundReportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FundReportScreen(),
      );
    },
    FundSessionListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FundSessionListScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MemberEditRoute.name: (routeData) {
      final args = routeData.argsAs<MemberEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MemberEditScreen(
          key: args.key,
          isCreateNew: args.isCreateNew,
          user: args.user,
        ),
      );
    },
    MemberReportRoute.name: (routeData) {
      final args = routeData.argsAs<MemberReportRouteArgs>(
          orElse: () => const MemberReportRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MemberReportScreen(key: args.key),
      );
    },
    MembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MembersScreen(),
      );
    },
    MultipleFundsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MultipleFundsScreen(),
      );
    },
    MultiplePaymentMembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MultiplePaymentMembersScreen(),
      );
    },
    PaycheckRoute.name: (routeData) {
      final args = routeData.argsAs<PaycheckRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaycheckScreen(
          key: args.key,
          payment: args.payment,
        ),
      );
    },
    PaymentDetailRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentDetailScreen(
          key: args.key,
          payment: args.payment,
        ),
      );
    },
    PaymentListOfUserRoute.name: (routeData) {
      final args = routeData.argsAs<PaymentListOfUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PaymentListOfUserScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    PdfExportReviewRoute.name: (routeData) {
      final args = routeData.argsAs<PdfExportReviewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PdfExportReviewScreen(
          key: args.key,
          fundReportToPdfViewModel: args.fundReportToPdfViewModel,
        ),
      );
    },
    SessionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SessionDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SessionDetailScreen(
          key: args.key,
          fundName: args.fundName,
          session: args.session,
          memberCount: args.memberCount,
        ),
      );
    },
  };
}

/// generated route for
/// [AddCustomBillScreen]
class AddCustomBillRoute extends PageRouteInfo<AddCustomBillRouteArgs> {
  AddCustomBillRoute({
    Key? key,
    required SubUserModel subuser,
    List<PageRouteInfo>? children,
  }) : super(
          AddCustomBillRoute.name,
          args: AddCustomBillRouteArgs(
            key: key,
            subuser: subuser,
          ),
          initialChildren: children,
        );

  static const String name = 'AddCustomBillRoute';

  static const PageInfo<AddCustomBillRouteArgs> page =
      PageInfo<AddCustomBillRouteArgs>(name);
}

class AddCustomBillRouteArgs {
  const AddCustomBillRouteArgs({
    this.key,
    required this.subuser,
  });

  final Key? key;

  final SubUserModel subuser;

  @override
  String toString() {
    return 'AddCustomBillRouteArgs{key: $key, subuser: $subuser}';
  }
}

/// generated route for
/// [CreateSessionEnterInfoScreen]
class CreateSessionEnterInfoRoute
    extends PageRouteInfo<CreateSessionEnterInfoRouteArgs> {
  CreateSessionEnterInfoRoute({
    Key? key,
    required FundMember fundMember,
    List<PageRouteInfo>? children,
  }) : super(
          CreateSessionEnterInfoRoute.name,
          args: CreateSessionEnterInfoRouteArgs(
            key: key,
            fundMember: fundMember,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateSessionEnterInfoRoute';

  static const PageInfo<CreateSessionEnterInfoRouteArgs> page =
      PageInfo<CreateSessionEnterInfoRouteArgs>(name);
}

class CreateSessionEnterInfoRouteArgs {
  const CreateSessionEnterInfoRouteArgs({
    this.key,
    required this.fundMember,
  });

  final Key? key;

  final FundMember fundMember;

  @override
  String toString() {
    return 'CreateSessionEnterInfoRouteArgs{key: $key, fundMember: $fundMember}';
  }
}

/// generated route for
/// [CreateSessionSelectMemberScreen]
class CreateSessionSelectMemberRoute extends PageRouteInfo<void> {
  const CreateSessionSelectMemberRoute({List<PageRouteInfo>? children})
      : super(
          CreateSessionSelectMemberRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateSessionSelectMemberRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardInfoScreen]
class DashboardInfoRoute extends PageRouteInfo<void> {
  const DashboardInfoRoute({List<PageRouteInfo>? children})
      : super(
          DashboardInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardInfoRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EmergencySessionCreateSelectMemberScreen]
class EmergencySessionCreateSelectMemberRoute extends PageRouteInfo<void> {
  const EmergencySessionCreateSelectMemberRoute({List<PageRouteInfo>? children})
      : super(
          EmergencySessionCreateSelectMemberRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmergencySessionCreateSelectMemberRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FinalSettlementForDeadSessionScreen]
class FinalSettlementForDeadSessionRoute extends PageRouteInfo<void> {
  const FinalSettlementForDeadSessionRoute({List<PageRouteInfo>? children})
      : super(
          FinalSettlementForDeadSessionRoute.name,
          initialChildren: children,
        );

  static const String name = 'FinalSettlementForDeadSessionRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FundBelongToSubUserScreen]
class FundBelongToSubUserRoute
    extends PageRouteInfo<FundBelongToSubUserRouteArgs> {
  FundBelongToSubUserRoute({
    Key? key,
    required int subUserId,
    required String subUserName,
    List<PageRouteInfo>? children,
  }) : super(
          FundBelongToSubUserRoute.name,
          args: FundBelongToSubUserRouteArgs(
            key: key,
            subUserId: subUserId,
            subUserName: subUserName,
          ),
          initialChildren: children,
        );

  static const String name = 'FundBelongToSubUserRoute';

  static const PageInfo<FundBelongToSubUserRouteArgs> page =
      PageInfo<FundBelongToSubUserRouteArgs>(name);
}

class FundBelongToSubUserRouteArgs {
  const FundBelongToSubUserRouteArgs({
    this.key,
    required this.subUserId,
    required this.subUserName,
  });

  final Key? key;

  final int subUserId;

  final String subUserName;

  @override
  String toString() {
    return 'FundBelongToSubUserRouteArgs{key: $key, subUserId: $subUserId, subUserName: $subUserName}';
  }
}

/// generated route for
/// [FundDetailScreen]
class FundDetailRoute extends PageRouteInfo<void> {
  const FundDetailRoute({List<PageRouteInfo>? children})
      : super(
          FundDetailRoute.name,
          initialChildren: children,
        );

  static const String name = 'FundDetailRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FundEditScreen]
class FundEditRoute extends PageRouteInfo<FundEditRouteArgs> {
  FundEditRoute({
    Key? key,
    required bool isNew,
    required GeneralFundModel? fund,
    List<PageRouteInfo>? children,
  }) : super(
          FundEditRoute.name,
          args: FundEditRouteArgs(
            key: key,
            isNew: isNew,
            fund: fund,
          ),
          initialChildren: children,
        );

  static const String name = 'FundEditRoute';

  static const PageInfo<FundEditRouteArgs> page =
      PageInfo<FundEditRouteArgs>(name);
}

class FundEditRouteArgs {
  const FundEditRouteArgs({
    this.key,
    required this.isNew,
    required this.fund,
  });

  final Key? key;

  final bool isNew;

  final GeneralFundModel? fund;

  @override
  String toString() {
    return 'FundEditRouteArgs{key: $key, isNew: $isNew, fund: $fund}';
  }
}

/// generated route for
/// [FundMembersScreen]
class FundMembersRoute extends PageRouteInfo<void> {
  const FundMembersRoute({List<PageRouteInfo>? children})
      : super(
          FundMembersRoute.name,
          initialChildren: children,
        );

  static const String name = 'FundMembersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FundNormalSessionExportPdfScreen]
class FundNormalSessionExportPdfRoute
    extends PageRouteInfo<FundNormalSessionExportPdfRouteArgs> {
  FundNormalSessionExportPdfRoute({
    Key? key,
    required NormalSessionDetail takenSessionDetail,
    required FundSession session,
    List<PageRouteInfo>? children,
  }) : super(
          FundNormalSessionExportPdfRoute.name,
          args: FundNormalSessionExportPdfRouteArgs(
            key: key,
            takenSessionDetail: takenSessionDetail,
            session: session,
          ),
          initialChildren: children,
        );

  static const String name = 'FundNormalSessionExportPdfRoute';

  static const PageInfo<FundNormalSessionExportPdfRouteArgs> page =
      PageInfo<FundNormalSessionExportPdfRouteArgs>(name);
}

class FundNormalSessionExportPdfRouteArgs {
  const FundNormalSessionExportPdfRouteArgs({
    this.key,
    required this.takenSessionDetail,
    required this.session,
  });

  final Key? key;

  final NormalSessionDetail takenSessionDetail;

  final FundSession session;

  @override
  String toString() {
    return 'FundNormalSessionExportPdfRouteArgs{key: $key, takenSessionDetail: $takenSessionDetail, session: $session}';
  }
}

/// generated route for
/// [FundReportScreen]
class FundReportRoute extends PageRouteInfo<void> {
  const FundReportRoute({List<PageRouteInfo>? children})
      : super(
          FundReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'FundReportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FundSessionListScreen]
class FundSessionListRoute extends PageRouteInfo<void> {
  const FundSessionListRoute({List<PageRouteInfo>? children})
      : super(
          FundSessionListRoute.name,
          initialChildren: children,
        );

  static const String name = 'FundSessionListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MemberEditScreen]
class MemberEditRoute extends PageRouteInfo<MemberEditRouteArgs> {
  MemberEditRoute({
    Key? key,
    required bool isCreateNew,
    required SubUserModel? user,
    List<PageRouteInfo>? children,
  }) : super(
          MemberEditRoute.name,
          args: MemberEditRouteArgs(
            key: key,
            isCreateNew: isCreateNew,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberEditRoute';

  static const PageInfo<MemberEditRouteArgs> page =
      PageInfo<MemberEditRouteArgs>(name);
}

class MemberEditRouteArgs {
  const MemberEditRouteArgs({
    this.key,
    required this.isCreateNew,
    required this.user,
  });

  final Key? key;

  final bool isCreateNew;

  final SubUserModel? user;

  @override
  String toString() {
    return 'MemberEditRouteArgs{key: $key, isCreateNew: $isCreateNew, user: $user}';
  }
}

/// generated route for
/// [MemberReportScreen]
class MemberReportRoute extends PageRouteInfo<MemberReportRouteArgs> {
  MemberReportRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MemberReportRoute.name,
          args: MemberReportRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MemberReportRoute';

  static const PageInfo<MemberReportRouteArgs> page =
      PageInfo<MemberReportRouteArgs>(name);
}

class MemberReportRouteArgs {
  const MemberReportRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MemberReportRouteArgs{key: $key}';
  }
}

/// generated route for
/// [MembersScreen]
class MembersRoute extends PageRouteInfo<void> {
  const MembersRoute({List<PageRouteInfo>? children})
      : super(
          MembersRoute.name,
          initialChildren: children,
        );

  static const String name = 'MembersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MultipleFundsScreen]
class MultipleFundsRoute extends PageRouteInfo<void> {
  const MultipleFundsRoute({List<PageRouteInfo>? children})
      : super(
          MultipleFundsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MultipleFundsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MultiplePaymentMembersScreen]
class MultiplePaymentMembersRoute extends PageRouteInfo<void> {
  const MultiplePaymentMembersRoute({List<PageRouteInfo>? children})
      : super(
          MultiplePaymentMembersRoute.name,
          initialChildren: children,
        );

  static const String name = 'MultiplePaymentMembersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PaycheckScreen]
class PaycheckRoute extends PageRouteInfo<PaycheckRouteArgs> {
  PaycheckRoute({
    Key? key,
    required PaymentModel payment,
    List<PageRouteInfo>? children,
  }) : super(
          PaycheckRoute.name,
          args: PaycheckRouteArgs(
            key: key,
            payment: payment,
          ),
          initialChildren: children,
        );

  static const String name = 'PaycheckRoute';

  static const PageInfo<PaycheckRouteArgs> page =
      PageInfo<PaycheckRouteArgs>(name);
}

class PaycheckRouteArgs {
  const PaycheckRouteArgs({
    this.key,
    required this.payment,
  });

  final Key? key;

  final PaymentModel payment;

  @override
  String toString() {
    return 'PaycheckRouteArgs{key: $key, payment: $payment}';
  }
}

/// generated route for
/// [PaymentDetailScreen]
class PaymentDetailRoute extends PageRouteInfo<PaymentDetailRouteArgs> {
  PaymentDetailRoute({
    Key? key,
    required PaymentModel payment,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentDetailRoute.name,
          args: PaymentDetailRouteArgs(
            key: key,
            payment: payment,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentDetailRoute';

  static const PageInfo<PaymentDetailRouteArgs> page =
      PageInfo<PaymentDetailRouteArgs>(name);
}

class PaymentDetailRouteArgs {
  const PaymentDetailRouteArgs({
    this.key,
    required this.payment,
  });

  final Key? key;

  final PaymentModel payment;

  @override
  String toString() {
    return 'PaymentDetailRouteArgs{key: $key, payment: $payment}';
  }
}

/// generated route for
/// [PaymentListOfUserScreen]
class PaymentListOfUserRoute extends PageRouteInfo<PaymentListOfUserRouteArgs> {
  PaymentListOfUserRoute({
    Key? key,
    required SubUserWithPaymentReport user,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentListOfUserRoute.name,
          args: PaymentListOfUserRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentListOfUserRoute';

  static const PageInfo<PaymentListOfUserRouteArgs> page =
      PageInfo<PaymentListOfUserRouteArgs>(name);
}

class PaymentListOfUserRouteArgs {
  const PaymentListOfUserRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final SubUserWithPaymentReport user;

  @override
  String toString() {
    return 'PaymentListOfUserRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [PdfExportReviewScreen]
class PdfExportReviewRoute extends PageRouteInfo<PdfExportReviewRouteArgs> {
  PdfExportReviewRoute({
    Key? key,
    required FundReportToPdfViewModel fundReportToPdfViewModel,
    List<PageRouteInfo>? children,
  }) : super(
          PdfExportReviewRoute.name,
          args: PdfExportReviewRouteArgs(
            key: key,
            fundReportToPdfViewModel: fundReportToPdfViewModel,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfExportReviewRoute';

  static const PageInfo<PdfExportReviewRouteArgs> page =
      PageInfo<PdfExportReviewRouteArgs>(name);
}

class PdfExportReviewRouteArgs {
  const PdfExportReviewRouteArgs({
    this.key,
    required this.fundReportToPdfViewModel,
  });

  final Key? key;

  final FundReportToPdfViewModel fundReportToPdfViewModel;

  @override
  String toString() {
    return 'PdfExportReviewRouteArgs{key: $key, fundReportToPdfViewModel: $fundReportToPdfViewModel}';
  }
}

/// generated route for
/// [SessionDetailScreen]
class SessionDetailRoute extends PageRouteInfo<SessionDetailRouteArgs> {
  SessionDetailRoute({
    Key? key,
    required String fundName,
    required FundSession session,
    required int memberCount,
    List<PageRouteInfo>? children,
  }) : super(
          SessionDetailRoute.name,
          args: SessionDetailRouteArgs(
            key: key,
            fundName: fundName,
            session: session,
            memberCount: memberCount,
          ),
          initialChildren: children,
        );

  static const String name = 'SessionDetailRoute';

  static const PageInfo<SessionDetailRouteArgs> page =
      PageInfo<SessionDetailRouteArgs>(name);
}

class SessionDetailRouteArgs {
  const SessionDetailRouteArgs({
    this.key,
    required this.fundName,
    required this.session,
    required this.memberCount,
  });

  final Key? key;

  final String fundName;

  final FundSession session;

  final int memberCount;

  @override
  String toString() {
    return 'SessionDetailRouteArgs{key: $key, fundName: $fundName, session: $session, memberCount: $memberCount}';
  }
}
