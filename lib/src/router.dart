import 'package:basenav/basenav.dart';
import 'package:flutter/widgets.dart';

import 'screen_route.dart';

/// A [Router] should aggregate the possible [ScreenRoute]s.
///
/// - [open] attempts to open a route from a [RouteSettings] (this is
/// usually called on [Navigator.onGenerateRoute]).
abstract class Router {
  const Router() : super();

  /// Retrieves a [ScreenRoute] from [settings].
  ///
  /// Returns null if none are found.
  ScreenRoute open(RouteSettings settings);
}

/// The simplest form of a [Router] that opens routes when [RouteSettings.name]
/// corresponds to a [routes] key-value.
class NamedMapRouter extends Router {
  const NamedMapRouter({@required this.routes})
      : assert(routes != null),
        super();

  final Map<String, ScreenRoute> routes;

  @override
  ScreenRoute open(RouteSettings settings) => routes[settings.name];
}
