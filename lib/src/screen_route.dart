import 'package:flutter/cupertino.dart';

import 'screen_route_transition.dart';

class ScreenRoute {
  ScreenRoute({
    this.transition,
    @required this.builder,
  })  : assert(builder != null),
        super();

  final ScreenRouteTransition transition;
  final WidgetBuilder builder;
}
