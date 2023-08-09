import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:hui_management/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

import 'app_route.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final context = router.navigatorKey.currentContext;

    if (context != null) {
      final provider = Provider.of<AuthenticationProvider>(context, listen: false);

      if (provider.model != null) {
        log('AuthGuard: user is logged in');

        resolver.next();
      } else {
        log('AuthGuard: not logged yet');
        resolver.redirect(LoginRoute());
      }
    } else {
      resolver.next();
    }
  }
}
