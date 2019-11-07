import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fnav/fnav.dart';

class ConcreteNavigation extends Navigation {
  const ConcreteNavigation({
    Key key,
    Widget child,
    @required BuildContext parentContext,
  }) : super(key: key, child: child, parentContext: parentContext);
}

void main() {
  BuildContext capturedContext;

  final builder = Builder(
    builder: (context) {
      capturedContext = context;
      return Container();
    },
  );

  tearDown(() {
    capturedContext = null;
  });

  test('given parentContext null', () {
    expect(() => ConcreteNavigation(parentContext: null), throwsAssertionError);
  });

  testWidgets('given child', (tester) async {
    final child = Container();
    await tester.pumpWidget(Builder(
      builder: (context) => ConcreteNavigation(
        parentContext: context,
        child: child,
      ),
    ));
    expect(find.byWidget(child), findsOneWidget);
  });

  group('.of', () {
    testWidgets('when in hierarchy', (tester) async {
      await tester.pumpWidget(builder);
      expect(Navigation.of(capturedContext), isNull);
    });

    testWidgets('when not in hierarchy', (tester) async {
      await tester.pumpWidget(Builder(
        builder: (context) => ConcreteNavigation(
          parentContext: context,
          child: builder,
        ),
      ));
      await tester.pump();
      expect(Navigation.of<ConcreteNavigation>(capturedContext), isNotNull);
    });
  });
}
