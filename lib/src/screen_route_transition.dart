import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ScreenRouteTransition<T> = Route<T> Function(
    WidgetBuilder, RouteSettings);

final ScreenRouteTransition materialScreenTransition = (builder, settings) =>
    MaterialPageRoute<dynamic>(builder: builder, settings: settings);

final ScreenRouteTransition cupertinoScreenTransition = (builder, settings) =>
    CupertinoPageRoute<dynamic>(builder: builder, settings: settings);
