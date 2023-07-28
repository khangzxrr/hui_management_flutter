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
