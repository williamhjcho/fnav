import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fnav/fnav.dart';

void main() {
  NamedMapRouter router;

  setUp(() {
    router = NamedMapRouter(routes: {
      'route-a': RouteDetails(builder: (_) => null),
    });
  });

  group('#open', () {
    test('when settings name is registered', () {
      final settings = RouteSettings(name: 'route-a');
      expect(router.open(settings), isNotNull);
    });

    test('when settings name is not registered', () {
      final settings = RouteSettings(name: 'route-c');
      expect(router.open(settings), isNull);
    });
  });
}
