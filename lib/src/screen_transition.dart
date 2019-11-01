import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ScreenTransition<T> = Route<T> Function(WidgetBuilder, RouteSettings);

final ScreenTransition materialScreenTransition = (builder, settings) =>
    MaterialPageRoute<dynamic>(builder: builder, settings: settings);

final ScreenTransition cupertinoScreenTransition = (builder, settings) =>
    CupertinoPageRoute<dynamic>(builder: builder, settings: settings);
