// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Function is able to create instances of type [T]
typedef FactoryMethod<T> = T Function();

/// Represents an object that allows an instance to be bound to some type
/// within the dependency injection container
abstract class Binder {
  /// Binds a function that will create a new instance of type [T] every time
  void bindsFactory<T>(FactoryMethod<T> factory, {String tag});

  /// Binds a function that should create a lazily-computed instance of type [T].
  /// The value computes on the first call to [get] and the same value is
  /// returned for all subsequent calls to [get].
  ///
  /// Note: lazy instance != singleton
  /// A lazy instance can be independent and keep its value separately
  /// from the other similar type [T] if contributed by the scoped module.
  /// If a singleton is required, contribute it through the unscoped module.
  void bindsLazyInstance<T>(FactoryMethod<T> factory, {String tag});

}
