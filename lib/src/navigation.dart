import 'package:flutter/cupertino.dart';

/// This class should coordinate the actual transitions usually starting from a
/// [BuildContext], be it from the [parentContext] (usually to go back/pop)
/// or a child's (usually to push/replace).
abstract class Navigation extends InheritedWidget {
  const Navigation({
    Key key,
    Widget child,
    @required this.parentContext,
  })  : assert(parentContext != null),
        super(key: key, child: child);

  final BuildContext parentContext;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static T of<T extends Navigation>(BuildContext context) =>
      context.inheritFromWidgetOfExactType(T);
}
