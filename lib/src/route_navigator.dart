import 'package:flutter/widgets.dart';

import 'screen_route.dart';
import 'screen_route_transition.dart';

typedef RouteBuilder = Route Function(RouteSettings);
typedef ScreenBuilder = ScreenRoute Function(RouteSettings);

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
            // TODO: assert/throw or let onUnknownRoute handle it?
            if (routeBuilder != null) return routeBuilder(settings);
            return null;
          },
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );
}

class ScreenRouteNavigator extends RouteNavigator {
  ScreenRouteNavigator({
    Key key,
    String initialRoute,
    @required Map<String, ScreenBuilder> routes,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
    ScreenRouteTransition defaultTransition,
  })  : assert(routes != null),
        super(
          key: key,
          initialRoute: initialRoute,
          routes: buildRoutesFrom(routes, defaultTransition),
          onUnknownRoute: onUnknownRoute,
          observers: observers,
        );

  static Map<String, RouteBuilder> buildRoutesFrom(
    Map<String, ScreenBuilder> routes,
    ScreenRouteTransition defaultTransition,
  ) {
    defaultTransition ??= materialScreenTransition;
    return routes.map<String, RouteBuilder>(
      (route, screenBuilder) => MapEntry(route, (settings) {
        // TODO: assert/throw?
        Route route;
        final screen = screenBuilder(settings);
        if (screen != null) {
          final transition = screen.transition ?? defaultTransition;
          route = transition(screen.builder, settings);
        }
        return route;
      }),
    );
  }
}
