import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//typedef ScreenRouteTransition<T> = Route<T> Function(
//    WidgetBuilder, RouteSettings);
//
//final ScreenRouteTransition materialRouteTransition = (builder, settings) =>
//    MaterialPageRoute<dynamic>(builder: builder, settings: settings);
//
//final ScreenRouteTransition cupertinoRouteTransition = (builder, settings) =>
//    CupertinoPageRoute<dynamic>(builder: builder, settings: settings);

/// Defines the transition to run between screens.
///
/// Usually it is a [MaterialPageRoute] or [CupertinoPageRoute] transitions.
///
/// See [materialRouteTransition] and [cupertinoRouteTransition].
abstract class RouteTransition<T> {
  const RouteTransition() : super();

  Route<T> transition(WidgetBuilder builder, RouteSettings settings);
}

class MaterialScreenTransition<T> extends RouteTransition<T> {
  const MaterialScreenTransition() : super();

  @override
  Route<T> transition(
    WidgetBuilder builder,
    RouteSettings settings, {
    bool fullscreenDialog = false,
    bool maintainState = true,
  }) =>
      MaterialPageRoute(
        builder: builder,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
      );
}

class CupertinoScreenTransition<T> extends RouteTransition<T> {
  const CupertinoScreenTransition() : super();

  @override
  Route<T> transition(
    WidgetBuilder builder,
    RouteSettings settings, {
    bool fullscreenDialog = false,
    bool maintainState = true,
  }) =>
      CupertinoPageRoute(
        builder: builder,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
        maintainState: maintainState,
      );
}

const materialRouteTransition = MaterialScreenTransition();

const cupertinoRouteTransition = CupertinoScreenTransition();
