import 'package:flutter/material.dart';
import 'package:fnav/fnav.dart';

import 'simple_screen.dart';

class _FeatureAScreen extends SimpleScreen {
  _FeatureAScreen({
    @required String title,
    int count = 0,
    @required VoidCallback onBack,
    @required VoidCallback onNext,
    VoidCallback onNextFeature,
  }) : super(
          title: title,
          count: count,
          backgroundColor: Colors.red,
          onBack: onBack,
          onNext: onNext,
          onNextFeature: onNextFeature,
        );
}

/* -------------------------------------------------------- */

/// Using pure flutter, all logic inside a single Navigator
/// The callbacks to other features are just to make it clear to understand only
/// what this class is solely responsible for, but they can be called from inside
/// this class as well.
///
/// The navigator here is responsible for:
/// - Knowing how to create all the screens that are presented
/// - handling their return types
/// - making the connection of one route to another (usually by receiving args)
/// - knowing how to transition in and out of a screen (push/pop/replace, and
/// transition animation)
class FeatureANavigator extends Navigator {
  FeatureANavigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case Navigator.defaultRouteName:
                builder = (context) => _FeatureAScreen(
                      title: 'Feture A',
                      onBack: onClose,
                      onNext: () =>
                          Navigator.pushNamed(context, 'another', arguments: 1),
                      onNextFeature: onNextFeature,
                    );
                break;
              case 'another':
                builder = (context) {
                  final int count = settings.arguments;

                  return _FeatureAScreen(
                    title: 'Feture A',
                    count: count,
                    onBack: () => Navigator.pop(context),
                    onNext: () => Navigator.pushNamed(context, 'another',
                        arguments: count + 1),
                    onNextFeature: onNextFeature,
                  );
                };
                break;
            }

            return MaterialPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        );
}

/* -------------------------------------------------------- */

/// Simple named key -> Route<T> map
/// Same as above but now integrates a [RouteNavigator] that only requires a
/// well defined [Map] to generate a new [Route] based only on
/// [RouteSettings.name]
class FeatureA1Navigator extends RouteNavigator {
  FeatureA1Navigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(routes: {
          '/': (settings) {
            return MaterialPageRoute(
              builder: (context) => _FeatureAScreen(
                title: 'Feature A1',
                onBack: onClose,
                onNext: () =>
                    Navigator.pushNamed(context, 'another', arguments: 1),
                onNextFeature: onNextFeature,
              ),
              settings: settings,
            );
          },
          'another': (settings) {
            return MaterialPageRoute(
              builder: (context) {
                final int count = settings.arguments;

                return _FeatureAScreen(
                  title: 'Feature A1',
                  count: count,
                  onBack: () => Navigator.pop(context),
                  onNext: () => Navigator.pushNamed(context, 'another',
                      arguments: count + 1),
                  onNextFeature: onNextFeature,
                );
              },
              settings: settings,
            );
          },
        });
}

/* -------------------------------------------------------- */

/// Simple named key -> Screen<dynamic> map
/// Same as above but now introduces the concept of a [RouteDetails], which
/// are simple encapsulated data objects that hold only the ui transition
/// method and the actual builder for the [Widget] being presented.
class FeatureA2Navigator extends ScreenRouteNavigator {
  FeatureA2Navigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(routes: {
          '/': (settings) {
            return RouteDetails(
              builder: (context) => _FeatureAScreen(
                title: 'Feature A2',
                onBack: onClose,
                onNext: () =>
                    Navigator.pushNamed(context, 'another', arguments: 1),
                onNextFeature: onNextFeature,
              ),
            );
          },
          'another': (settings) {
            return RouteDetails(
              builder: (context) {
                final int count = settings.arguments;

                return _FeatureAScreen(
                  title: 'Feature A2',
                  count: count,
                  onBack: () => Navigator.pop(context),
                  onNext: () => Navigator.pushNamed(context, 'another',
                      arguments: count + 1),
                  onNextFeature: onNextFeature,
                );
              },
            );
          },
        });
}

/* -------------------------------------------------------- */

/// Same as above, introduces the concept of a Router class that
/// is responsible for containing the UI presentation logic
/// ([RouteSettings]) -> [RouteDetails].
///
/// Here a navigator is only responsible for registering a router and
/// registering the callbacks that are outside this navigator's responsibility
class FeatureA3Navigator extends RouterNavigator {
  FeatureA3Navigator({
    @required VoidCallback onClose,
    @required VoidCallback onNextFeature,
  }) : super(
          router: FeatureA3Router(
            onClose: onClose,
            onNextFeature: onNextFeature,
          ),
        );
}

/// The router is the one that knows:
/// - how to open each screen
/// - register the in and out args from the routes
/// - add the transition types (if not using some default)
/// - handles (RouteSettings) -> Route logic
class FeatureA3Router extends Router {
  const FeatureA3Router({
    @required this.onClose,
    @required this.onNextFeature,
  }) : super();

  final VoidCallback onClose, onNextFeature;

  RouteDetails<void> home() => RouteDetails(builder: (context) {
        return _FeatureAScreen(
          title: 'Feature A3',
          onBack: onClose,
          onNext: () => Navigator.pushNamed(context, 'another', arguments: 1),
          onNextFeature: onNextFeature,
        );
      });

  RouteDetails<void> another(int count) => RouteDetails(builder: (context) {
        return _FeatureAScreen(
          title: 'Feature A3',
          count: count,
          onBack: () => Navigator.pop(context),
          onNext: () =>
              Navigator.pushNamed(context, 'another', arguments: count + 1),
          onNextFeature: onNextFeature,
        );
      });

  @override
  RouteDetails<void> open(RouteSettings settings) {
    if (settings.name == Navigator.defaultRouteName) {
      return home();
    } else {
      return another(settings.arguments);
    }
  }
}

/* -------------------------------------------------------- */

/// Same as above, introduces a Navigation class that is responsible for
/// containing all logic of how a new transition should occur (how to open one
/// screen or a deeplink) and have the necessary strong types (arguments and
/// return)
class FeatureA4Navigator extends StatelessWidget {
  const FeatureA4Navigator() : super();

  @override
  Widget build(BuildContext context) {
    return FeatureA4Navigation(
      parentContext: context,
      child: RouterNavigator(router: FeatureA4Router()),
    );
  }
}

class FeatureA4Router extends Router {
  const FeatureA4Router() : super();

  RouteDetails<void> home() => RouteDetails(builder: (context) {
        final navigation = FeatureA4Navigation.of(context);

        return _FeatureAScreen(
          title: 'Feature A4',
          onBack: navigation.close,
          onNext: () => navigation.toAnother(context, count: 1),
          onNextFeature: navigation.toFeatureB,
        );
      });

  RouteDetails<void> another(int count) => RouteDetails(builder: (context) {
        final navigation = FeatureA4Navigation.of(context);

        return _FeatureAScreen(
          title: 'Feature A4',
          count: count,
          onBack: () => Navigator.pop(context),
          onNext: () => navigation.toAnother(context, count: count + 1),
          onNextFeature: navigation.toFeatureB,
        );
      });

  @override
  RouteDetails open(RouteSettings settings) {
    if (settings.name == Navigator.defaultRouteName) {
      return home();
    } else {
      return another(settings.arguments);
    }
  }
}

/// This class coordinates the actual transition calls. This is useful only to
/// define transitions, instead of using named constructor callbacks (requiring
/// features to know about this navigation (how do you test such class that is
/// created statically?)
///
/// e.g. feature A opens Feature B when a button is tapped
class FeatureA4Navigation extends Navigation {
  const FeatureA4Navigation({
    Key key,
    Widget child,
    @required BuildContext parentContext,
  }) : super(key: key, child: child, parentContext: parentContext);

  /// closes flow (feature A)
  bool close() => Navigator.of(parentContext).pop();

  /// requires this navigation to know only the url for the other feature
  Future<void> toFeatureB() => Navigator.of(parentContext).pushNamed('b');

  // This one is only for taxonomy, since it is the first thing the router
  // already presents.
  // This might be more useful if the flow required to pop to the first target
  // for example
//  Future<void> toHome(BuildContext context) => Navigator.of(context).pushNamed('/');

  Future<void> toAnother(BuildContext context, {@required int count}) =>
      Navigator.of(context).pushNamed('/another', arguments: count);

  static FeatureA4Navigation of(BuildContext context) => Navigation.of(context);
}
