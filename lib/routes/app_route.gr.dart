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
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardScreen(),
      );
    },
    MultipleFundsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MultipleFundsScreen(),
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
    FundSessionListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const FundSessionListScreen(),
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
    SessionDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SessionDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SessionDetailScreen(
          key: args.key,
          fundName: args.fundName,
          session: args.session,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(key: args.key),
      );
    },
    MembersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MembersScreen(),
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
    MultiplePaymentMembersRoute.name: (routeData) {
      final args = routeData.argsAs<MultiplePaymentMembersRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MultiplePaymentMembersScreen(
          key: args.key,
          users: args.users,
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
    MemberReportRoute.name: (routeData) {
      final args = routeData.argsAs<MemberReportRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MemberReportScreen(
          key: args.key,
          userReportModels: args.userReportModels,
        ),
      );
    },
  };
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
/// [SessionDetailScreen]
class SessionDetailRoute extends PageRouteInfo<SessionDetailRouteArgs> {
  SessionDetailRoute({
    Key? key,
    required String fundName,
    required FundSession session,
    List<PageRouteInfo>? children,
  }) : super(
          SessionDetailRoute.name,
          args: SessionDetailRouteArgs(
            key: key,
            fundName: fundName,
            session: session,
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
  });

  final Key? key;

  final String fundName;

  final FundSession session;

  @override
  String toString() {
    return 'SessionDetailRouteArgs{key: $key, fundName: $fundName, session: $session}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<LoginRouteArgs> page = PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
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
/// [MemberEditScreen]
class MemberEditRoute extends PageRouteInfo<MemberEditRouteArgs> {
  MemberEditRoute({
    Key? key,
    required bool isCreateNew,
    required UserModel? user,
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

  final UserModel? user;

  @override
  String toString() {
    return 'MemberEditRouteArgs{key: $key, isCreateNew: $isCreateNew, user: $user}';
  }
}

/// generated route for
/// [MultiplePaymentMembersScreen]
class MultiplePaymentMembersRoute
    extends PageRouteInfo<MultiplePaymentMembersRouteArgs> {
  MultiplePaymentMembersRoute({
    Key? key,
    required List<UserModel> users,
    List<PageRouteInfo>? children,
  }) : super(
          MultiplePaymentMembersRoute.name,
          args: MultiplePaymentMembersRouteArgs(
            key: key,
            users: users,
          ),
          initialChildren: children,
        );

  static const String name = 'MultiplePaymentMembersRoute';

  static const PageInfo<MultiplePaymentMembersRouteArgs> page =
      PageInfo<MultiplePaymentMembersRouteArgs>(name);
}

class MultiplePaymentMembersRouteArgs {
  const MultiplePaymentMembersRouteArgs({
    this.key,
    required this.users,
  });

  final Key? key;

  final List<UserModel> users;

  @override
  String toString() {
    return 'MultiplePaymentMembersRouteArgs{key: $key, users: $users}';
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
/// [PaymentListOfUserScreen]
class PaymentListOfUserRoute extends PageRouteInfo<PaymentListOfUserRouteArgs> {
  PaymentListOfUserRoute({
    Key? key,
    required UserModel user,
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

  final UserModel user;

  @override
  String toString() {
    return 'PaymentListOfUserRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [MemberReportScreen]
class MemberReportRoute extends PageRouteInfo<MemberReportRouteArgs> {
  MemberReportRoute({
    Key? key,
    required List<UserReportModel> userReportModels,
    List<PageRouteInfo>? children,
  }) : super(
          MemberReportRoute.name,
          args: MemberReportRouteArgs(
            key: key,
            userReportModels: userReportModels,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberReportRoute';

  static const PageInfo<MemberReportRouteArgs> page =
      PageInfo<MemberReportRouteArgs>(name);
}

class MemberReportRouteArgs {
  const MemberReportRouteArgs({
    this.key,
    required this.userReportModels,
  });

  final Key? key;

  final List<UserReportModel> userReportModels;

  @override
  String toString() {
    return 'MemberReportRouteArgs{key: $key, userReportModels: $userReportModels}';
  }
}
