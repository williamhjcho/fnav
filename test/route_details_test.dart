import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fnav/fnav.dart';
import 'package:mockito/mockito.dart';

class MockRouteTransition extends Mock implements RouteTransition {}

void main() {
  test('given build null', () {
    expect(() => RouteDetails(builder: null), throwsAssertionError);
  });

  group('#buildRoute', () {
    WidgetBuilder builder;
    MockRouteTransition transition;

    setUp(() {
      builder = expectAsync1(null, count: 0);
      transition = MockRouteTransition();
    });

    test('without initial transition', () {
      final details = RouteDetails(builder: builder);
      final settings = RouteSettings();

      expect(details.buildRoute(settings), isNull);
    });

    test('given transition', () {
      final details = RouteDetails(transition: transition, builder: builder);
      final settings = RouteSettings();

      expect(() => details.buildRoute(settings), returnsNormally);
      verify(transition.transition(builder, settings)).called(1);
    });

    test('given transition and fallbackTransition', () {
      final fallbackTransition = MockRouteTransition();
      final details = RouteDetails(transition: transition, builder: builder);
      final settings = RouteSettings();

      expect(
        () => details.buildRoute(
          settings,
          fallbackTransition: fallbackTransition,
        ),
        returnsNormally,
      );
      verify(transition.transition(builder, settings)).called(1);
      verifyNever(fallbackTransition.transition(any, any));
    });
  });
}
