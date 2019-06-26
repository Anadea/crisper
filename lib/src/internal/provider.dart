// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'util.dart';

/// Represents a class that provides instances of type [T]
abstract class Provider<T> {
  /// Return the underlying value, computing the value if necessary
  T get();
}

/// Used by the library to create a [Provider] instance
Provider<T> getProvider<T>(T Function() factory, {bool asLazy = false}) =>
    asLazy
        ? _LazyInstanceProvider._internal(factory)
        : _FactoryProvider._internal(factory);

/// Basic [Provider] used by the library
abstract class _BaseProvider<T> implements Provider<T> {
  final T Function() _factory;
  bool _resolve = false;

  _BaseProvider._internal(T Function() factory)
      : this._factory = checkNotNull(factory,
            "Function that creates the object of type [$T] must not be null");

  @override
  T get() {
    if (_resolve) {
      throw StateError(
          "Circular dependency on the object of type [$T] was detected");
    }

    _resolve = true;
    final instance = _build();
    _resolve = false;

    return instance;
  }

  T _build();
}

/// Factory [Provider] implementations used by the library.
class _FactoryProvider<T> extends _BaseProvider<T> {
  _FactoryProvider._internal(T Function() factory) : super._internal(factory);

  @override
  T _build() => _factory();
}

/// LazyInstance [Provider] implementations used by the library.
class _LazyInstanceProvider<T> extends _BaseProvider<T> {
  _LazyInstanceProvider._internal(T Function() factory)
      : super._internal(factory);

  T _instance;

  @override
  T _build() => _instance ??= _factory();
}
