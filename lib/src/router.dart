import 'package:flutter/widgets.dart';

import 'route_details.dart';

/// A [Router] should aggregate the possible [RouteDetails]s.
///
/// - [open] attempts to open a route from a [RouteSettings] (this is
/// usually called on [Navigator.onGenerateRoute]).
abstract class Router {
  const Router() : super();

  /// Retrieves a [RouteDetails] from [settings].
  ///
  /// Returns null if none are found.
  RouteDetails open(RouteSettings settings);
}

/// The simplest form of a [Router] that opens routes when [RouteSettings.name]
/// corresponds to a [routes] key-value.
class NamedMapRouter extends Router {
  const NamedMapRouter({@required this.routes})
      : assert(routes != null),
        super();

  final Map<String, RouteDetails> routes;

  @override
  RouteDetails open(RouteSettings settings) => routes[settings.name];
}
