import 'package:flutter_test/flutter_test.dart';

class MyClass {
  MyClass() {
    print('init MyClass');
  }

  void call() {
    print('MyClass calling');
  }
}

abstract class MyInter {
  final int val0 = -1;
  int get val1;

  String getStuff(String value) => value.toUpperCase();
}

class MyConcrete extends MyInter {
  @override
  int get val0 => 0;

  @override
  int get val1 => 1;
}

void main() {
  test('', () {
    final void Function() func = MyClass();
    func();
    func();
    func();
  });

  test('double parses', () {
    expect(double.parse('123'), 123);
    expect(double.parse('123'), 123.0);
    expect(double.parse('123.456'), 123.456);
    expect(double.parse('-000123.456'), -123.456);
  });

  test('another', () {
    const a = <int>[0, 1];
    final b = <int>[2, 3];
    expect(a + b, [0, 1, 2, 3]);

    List<int> v;
    expect((v ?? []) + a, [0, 1]);
  });

  test('asd', () {
    final instance = MyConcrete();
    expect(instance.val0, 0);
    expect(instance.val1, 1);
    expect(instance.getStuff('value'), 'VALUE');

    final MyInter interfaced = instance;
    expect(interfaced.val0, 0);
    expect(interfaced.val1, 1);
    expect(interfaced.getStuff('value'), 'VALUE');
  });
}
