// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'internal/binder.dart';
import 'internal/provider.dart';
import 'internal/util.dart';
import 'module.dart';

/// Used by the library to retrieve a dependency instance of type [T]
/// tagged with [tag] and scoped by [scope]
T retrieve<T>({Type scope, String tag}) => _container._retrieve<T>(scope, tag);

final IoContainer _container = IoContainer._internal();

/// Dependency injection container
class IoContainer {
  final _generalKey = "general::";

  final Map<String, Map<String, Provider<dynamic>>> _store = {};

  IoContainer._internal();

  /// Returns a container instance
  factory IoContainer.take() => _container;

  /// Adds dependencies contributed by [module] and scoped by [scope]
  void add(Module module, {Type scope}) =>
      checkNotNull(module, "Module must not be null")
          .setup(getBinder(_createStoreIfNeed(scope)));

  /// Removes all dependencies scoped by [scope]
  void removeScope(Type scope) => _store.remove(keyOf(scope));

  /// Removes all registered dependencies
  void reset() => _store.clear();

  Map<String, Provider<dynamic>> _createStoreIfNeed(Type scope) =>
      _store[scope == null ? _generalKey : keyOf(scope)] ??= {};

  T _retrieve<T>(Type scope, String tag) => checkNotNull(
          _getProvider(
              scope == null ? _generalKey : keyOf(scope), keyOf(T, tag: tag)),
          "Dependency of type ${descOf<T>(scope: scope, tag: tag)} is not found")
      .get() as T;

  Provider<dynamic> _getProvider(String scopeKey, String providerKey) =>
      _store[scopeKey] != null ? _store[scopeKey][providerKey] : null;
}
