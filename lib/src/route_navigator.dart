import 'package:flutter/widgets.dart';

typedef RouteBuilder = Route Function(RouteSettings);

class RouteNavigator extends Navigator {
  RouteNavigator({
    Key key,
    String initialRoute = Navigator.defaultRouteName,
    Map<String, RouteBuilder> routes,
    RouteFactory onUnknownRoute,
    List<NavigatorObserver> observers = const <NavigatorObserver>[],
  }) : super(
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
