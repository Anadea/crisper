import 'package:test/test.dart';

import 'package:crisper/src/internal/binder.dart';
import 'package:crisper/src/internal/util.dart';
import 'package:crisper/src/internal/provider.dart';

void main() {
  final Map<String, Provider<dynamic>> destination = {};
  final tag = "tag";

  group("Common binder", () {
    final binder = getBinder(destination);

    group("Factory binding", () {
      tearDown(() => destination.clear());

      test('binds a factory', () {
        final key = keyOf(Object);
        expect(destination.containsKey(key), false);
        binder.bindsFactory<Object>(() => Object());

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);
      });

      test('binds a tagged factory', () {
        final key = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        binder.bindsFactory<Object>(() => Object(), tag: tag);

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);
      });

      test('binds two factory of the same type but one of them is tagged', () {
        final key = keyOf(Object);
        final taggedKey = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        expect(destination.containsKey(taggedKey), false);
        binder.bindsFactory<Object>(() => Object());
        binder.bindsFactory<Object>(() => Object(), tag: tag);

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), false);

        final Object four = destination[taggedKey].get();
        final Object five = destination[taggedKey].get();
        expect(four, isNotNull);
        expect(five, isNotNull);
        expect(identical(four, five), false);
      });

      test('throw an error than dependency is already defined', () {
        final key = keyOf(Object);
        final taggedKey = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        expect(destination.containsKey(taggedKey), false);
        binder.bindsFactory<Object>(() => Object());
        binder.bindsFactory<Object>(() => Object(), tag: tag);

        expect(
            () => binder.bindsFactory<Object>(() => Object()),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] is already defined')));

        expect(
            () => binder.bindsFactory<Object>(() => Object(), tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] tagged with [tag]'
                        ' is already defined')));
      });
    });

    group("Lazy instance binding", () {
      tearDown(() => destination.clear());

      test('binds a lazy instance', () {
        final key = keyOf(Object);
        expect(destination.containsKey(key), false);
        binder.bindsLazyInstance<Object>(() => Object());

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), true);
      });

      test('binds a tagged lazy instance', () {
        final key = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        binder.bindsLazyInstance<Object>(() => Object(), tag: tag);

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), true);
      });

      test('binds two lazy instance of the same type but on of them is tagged',
          () {
        final key = keyOf(Object);
        final taggedKey = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        expect(destination.containsKey(taggedKey), false);
        binder.bindsLazyInstance<Object>(() => Object());
        binder.bindsLazyInstance<Object>(() => Object(), tag: tag);

        final Object one = destination[key].get();
        final Object two = destination[key].get();
        expect(one, isNotNull);
        expect(two, isNotNull);
        expect(identical(one, two), true);

        final Object four = destination[taggedKey].get();
        final Object five = destination[taggedKey].get();
        expect(four, isNotNull);
        expect(five, isNotNull);
        expect(identical(four, five), true);
      });

      test('throw an error than dependency is already defined', () {
        final key = keyOf(Object);
        final taggedKey = keyOf(Object, tag: tag);
        expect(destination.containsKey(key), false);
        expect(destination.containsKey(taggedKey), false);
        binder.bindsLazyInstance<Object>(() => Object());
        binder.bindsLazyInstance<Object>(() => Object(), tag: tag);

        expect(
            () => binder.bindsLazyInstance<Object>(() => Object()),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message == 'Dependency of type [Object] is already defined')));

        expect(
            () => binder.bindsLazyInstance<Object>(() => Object(), tag: tag),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message ==
                    'Dependency of type [Object] tagged with [tag]'
                        ' is already defined')));
      });
    });
  });
}
