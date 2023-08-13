import 'package:auto_route/auto_route.dart';

class RouteObserver extends AutoRouterObserver {
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    print('didInitTabRoute: ${route.name}');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    print('didChangeTabRoute: ${route.name}');
    super.didChangeTabRoute(route, previousRoute);
  }
}
