import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fnav/fnav.dart';

void main() {
  final settings = RouteSettings();

  test('MaterialScreenTransition', () {
    final transition = MaterialScreenTransition<String>();
    expect(
      transition.transition(expectAsync1(null, count: 0), settings),
      isA<MaterialPageRoute<String>>(),
    );
  });

  test('CupertinoScreenTransition', () {
    final transition = CupertinoScreenTransition<String>();
    expect(
      transition.transition(expectAsync1(null, count: 0), settings),
      isA<CupertinoPageRoute<String>>(),
    );
  });
}
