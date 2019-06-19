import 'package:test/test.dart';

import 'package:crisper/src/internal/util.dart';

Type _typeOf<T>() => T;

void main() {

  group("Util", () {
    group("keyOf", () {
      test('throw an error that it unable to infer the type of `null`', () {
        expect(
            () => keyOf(null),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message == 'Unable to infer the type [null]')));
      });

      test('throw an error that it unable to infer the type of `dynamic`', () {
        expect(
            () => keyOf(_typeOf<dynamic>()),
            throwsA(predicate<Error>((e) =>
                e is ArgumentError &&
                e.message == 'Unable to infer the type [dynamic]')));
      });

      test('successful key creation', () {
        expect(keyOf(String), "[String]");
        expect(keyOf(String, tag: "tag"), "[String]::[tag]");
      });
    });

    test('creating description', () {
      expect(descOf<String>(), "[String]");
      expect(descOf<String>(scope: Object), "[String] scoped by [Object]");
      expect(descOf<String>(tag: "tag"), "[String] tagged with [tag]");
      expect(descOf<String>(scope: Object, tag: "tag"),
          "[String] tagged with [tag] scoped by [Object]");
    });

    group("checkNotNull", () {
      test('throw an error if the [reference] is `null` and message is absent',
          () {
        expect(
            () => checkNotNull<String>(null),
            throwsA(predicate<Error>(
                (e) => e is ArgumentError && e.message == 'Must not be null')));
      });

      test('throw an error if the [reference] is `null` and custom message',
          () {
        expect(
            () => checkNotNull<String>(null, "message"),
            throwsA(predicate<Error>(
                (e) => e is ArgumentError && e.message == 'message')));
      });

      test('returns the [reference] parameter', () {
        final obj = Object();
        expect(identical(obj, checkNotNull(obj)), true);
      });
    });
  });
}
