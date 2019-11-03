import 'package:flutter/cupertino.dart';

import 'screen_route_transition.dart';

class ScreenRoute {
  ScreenRoute({
    this.transition,
    @required this.builder,
  })  : assert(builder != null),
        super();

  /// The transition used when presenting the [builder].
  ///
  /// If null defaults to [ScreenRouteNavigator.defaultTransition].
  final ScreenRouteTransition transition;
  final WidgetBuilder builder;

  Route<T> buildRoute<T>(RouteSettings settings,
      {ScreenRouteTransition fallbackTransition}) {
    final effectiveTransition = transition ?? fallbackTransition;
    return effectiveTransition.transition(builder, settings);
  }
}
