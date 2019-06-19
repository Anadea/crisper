import 'package:test/test.dart';

import 'package:crisper/crisper.dart';
import 'package:crisper/src/binder.dart';
import 'package:crisper/src/module.dart';

final tag = "tag";

void main() {
  group("IoContainer", () {
    group("Errors", () {
      setUpAll(() => IoContainer.take().reset());

      test('throw an error than dependency is not found', () {
        expect(
            () => get<Object>(),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message == 'Dependency of type [Object] is not found')));
        expect(
                () => get<Object>(tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] tagged with [tag] is not found')));
        expect(
            () => get<Object>(scope: String),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] scoped by [String] is not found')));
        expect(
            () => get<Object>(scope: String, tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] tagged with [tag]'
                        ' scoped by [String] is not found')));
      });

      test('throw an error than module must not be null', () {
        expect(
            () => IoContainer.take().add(null),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError && e.message == 'Module must not be null')));
      });
    });

    group("Unscoped dependency", () {
      setUpAll(() => IoContainer.take().add(_CommonModule()));
      tearDownAll(() => IoContainer.take().reset());

      test('factory', () {
        final one = get<Object>();
        final two = get<Object>();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);

        final four = get<Object>(tag: tag);
        final five = get<Object>(tag: tag);
        expect(four, isNotNull);
        expect(five, isNotNull);
        expect(identical(four, five), false);
      });

      test('factory with tag', () {
        final one = get<Object>(tag: tag);
        final two = get<Object>(tag: tag);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);
      });

      test('lazy instance', () {
        final one = get<_Interface>();
        final two = get<_Interface>();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), true);
      });

      test('lazy instance with tag', () {
        final one = get<_Interface>(tag: tag);
        final two = get<_Interface>(tag: tag);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), true);
      });
    });

    group("Scoped dependency", () {
      setUpAll(() => IoContainer.take().add(_CommonModule(), scope: String));
      tearDownAll(() => IoContainer.take().reset());

      //;

      test('factory', () {
        final one = get<Object>(scope: String);
        final two = get<Object>(scope: String);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);

        final four = get<Object>(scope: String, tag: tag);
        final five = get<Object>(scope: String, tag: tag);
        expect(four, isNotNull);
        expect(five, isNotNull);
        expect(identical(four, five), false);
      });

      test('factory with tag', () {
        final one = get<Object>(scope: String, tag: tag);
        final two = get<Object>(scope: String, tag: tag);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);
      });

      test('lazy instance', () {
        final one = get<_Interface>(scope: String);
        final two = get<_Interface>(scope: String);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), true);
      });

      test('lazy instance with tag', () {
        final one = get<_Interface>(scope: String, tag: tag);
        final two = get<_Interface>(scope: String, tag: tag);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), true);
      });
    });

    group("Independence the unscoped and scoped dependencies", () {
      setUpAll(() {
        IoContainer.take().add(_CommonModule());
        IoContainer.take().add(_CommonModule(), scope: String);
      });
      tearDownAll(() => IoContainer.take().reset());

      test('lazy instance', () {
        final one = get<_Interface>();
        final two = get<_Interface>(scope: String);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), false);
      });

      test('lazy instance with tag', () {
        final one = get<_Interface>(tag: tag);
        final two = get<_Interface>(scope: String, tag: tag);
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one.value, two.value), false);
      });
    });

    group("Remove scope", () {
      setUpAll(() {
        IoContainer.take().add(_CommonModule(), scope: String);
      });
      tearDownAll(() => IoContainer.take().reset());
      test('no dependencies after removing the scope', () {

        expect(get<Object>(scope: String), isNotNull);
        expect(get<Object>(scope: String, tag: tag), isNotNull);
        expect(get<_Interface>(scope: String), isNotNull);
        expect(get<_Interface>(scope: String, tag: tag), isNotNull);

        IoContainer.take().removeScope(String);

        expect(
            () => get<Object>(scope: String),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] scoped by [String]'
                        ' is not found')));
        expect(
            () => get<Object>(scope: String, tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] tagged with [tag]'
                        ' scoped by [String] is not found')));
        expect(
            () => get<_Interface>(scope: String),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [_Interface] scoped by [String]'
                        ' is not found')));
        expect(
            () => get<_Interface>(scope: String, tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [_Interface] tagged with [tag]'
                        ' scoped by [String] is not found')));
      });
    });
  });
}

abstract class _Interface {
  Object get value;
}

class _InterfaceImpl implements _Interface {
  final _value = Object();

  @override
  Object get value => _value;
}

class _CommonModule implements Module {
  @override
  void setup(Binder binder) {
    binder.bindsFactory<Object>(() => Object());
    binder.bindsFactory<Object>(() => Object(), tag: tag);
    binder.bindsLazyInstance<_Interface>(() => _InterfaceImpl());
    binder.bindsLazyInstance<_Interface>(() => _InterfaceImpl(), tag: tag);
  }
}
