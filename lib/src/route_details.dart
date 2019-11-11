import 'package:flutter/widgets.dart';

import 'route_transition.dart';

/// A [Route] data object with the necessary information for transitioning to
/// a new [Route].
class RouteDetails<T> {
  const RouteDetails({
    this.transition,
    @required this.builder,
  })  : assert(builder != null),
        super();

  /// The transition used when presenting the [builder].
  ///
  /// If null defaults to [ScreenRouteNavigator.defaultTransition].
  final RouteTransition<T> transition;
  final WidgetBuilder builder;

  Route<T> buildRoute<T>(RouteSettings settings,
      {RouteTransition fallbackTransition}) {
    final effectiveTransition = transition ?? fallbackTransition;
    return effectiveTransition?.transition(builder, settings);
  }
}
