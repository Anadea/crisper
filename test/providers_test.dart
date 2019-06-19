import 'package:test/test.dart';

import 'package:crisper/src/internal/provider.dart';

void main() {
  group("Providers", () {
    test('throw an error when the factory method is `null`', () {
      expect(
          () => getProvider<Object>(null),
          throwsA(predicate<Error>((e) =>
              e is ArgumentError &&
              e.message ==
                  'Function that creates the object of type [Object]'
                      ' must not be null')));
    });

    test('throw an error that a circular dependency was detected', () {
      Provider<Object> providerOne;
      Provider<Object> providerTwo;

      providerOne = getProvider<Object>(() => providerTwo.get());
      providerTwo = getProvider<Object>(() => providerOne.get());

      expect(
          () => providerOne.get(),
          throwsA(predicate<Error>((e) =>
              e is StateError &&
              e.message ==
                  'Circular dependency on the object of type [Object]'
                      ' was detected')));
    });

    test('successful factory provider creation', () {
      final provider = getProvider<Object>(() => Object());
      final one = provider.get();
      final two = provider.get();
      expect(one, isNotNull);
      expect(two, isNotNull);
      expect(identical(one, two), false);
    });

    test('successful instance provider creation', () {
      final provider = getProvider<Object>(() => Object(), asLazy: true);
      final one = provider.get();
      final two = provider.get();
      expect(one, isNotNull);
      expect(two, isNotNull);
      expect(identical(one, two), true);
    });
  });
}
