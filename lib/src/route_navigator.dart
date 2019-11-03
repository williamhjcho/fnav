import 'package:flutter/widgets.dart';

import 'route_details.dart';
import 'route_transition.dart';
import 'router.dart';

typedef RouteBuilder = Route Function(RouteSettings);
typedef ScreenBuilder = RouteDetails Function(RouteSettings);

/// A simple [Navigator] that handles navigation via a registry of [routes]
class RouteNavigator extends Navigator {
  RouteNavigator({
    Key key,
    String initialRoute,
    @required Map<String, RouteBuilder> routes,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
  })  : assert(routes != null),
        super(
          key: key,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            final routeBuilder = routes[settings.name];
            if (routeBuilder != null) return routeBuilder(settings);
            return null;
          },
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );
}

/// A [RouteNavigator] that handles navigation via a registry of [routes] that
/// generate [RouteDetails]s instead.
class ScreenRouteNavigator extends RouteNavigator {
  ScreenRouteNavigator({
    Key key,
    String initialRoute,
    @required Map<String, ScreenBuilder> routes,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
    RouteTransition defaultTransition = materialRouteTransition,
  })  : assert(routes != null),
        assert(defaultTransition != null),
        super(
          key: key,
          initialRoute: initialRoute,
          routes: buildRoutesFrom(routes, defaultTransition),
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );

  static Map<String, RouteBuilder> buildRoutesFrom(
    Map<String, ScreenBuilder> routes,
    RouteTransition defaultTransition,
  ) {
    return routes.map<String, RouteBuilder>(
      (route, screenBuilder) => MapEntry(route, (settings) {
        final screen = screenBuilder(settings);
        return screen?.buildRoute(
          settings,
          fallbackTransition: defaultTransition,
        );
      }),
    );
  }
}

/// A [Navigator] that uses a [Router] to handle the actual [Route] transitions,
/// while this [Navigator] is responsible for observation and access from the
/// [Widget] tree.
class RouterNavigator extends Navigator {
  RouterNavigator({
    Key key,
    String initialRoute,
    @required Router router,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
    RouteTransition defaultTransition = materialRouteTransition,
  })  : assert(router != null),
        assert(defaultTransition != null),
        super(
          key: key,
          initialRoute: initialRoute,
          onGenerateRoute: (settings) {
            final screen = router.open(settings);
            return screen?.buildRoute(
              settings,
              fallbackTransition: defaultTransition,
            );
          },
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );
}
