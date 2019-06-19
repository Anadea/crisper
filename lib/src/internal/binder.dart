// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../binder.dart';
import 'provider.dart';
import 'util.dart';

/// Used by the library to create a [Binder] instance.
Binder getBinder(Map<String, Provider<dynamic>> destination) =>
    _CommonBinder._internal(destination);

/// Common [Binder] implementations used by the library.
class _CommonBinder implements Binder {
  final Map<String, Provider<dynamic>> _container;

  _CommonBinder._internal(this._container);

  @override
  void bindsFactory<T>(FactoryMethod<T> factory, {String tag}) =>
      _bind<T>(getProvider<T>(factory), tag);

  @override
  void bindsLazyInstance<T>(FactoryMethod<T> factory, {String tag}) =>
      _bind<T>(getProvider(factory, asLazy: true), tag);

  void _bind<T>(Provider<T> provider, [String tag]) {
    final key = keyOf(T, tag: tag);
    if (_container.containsKey(key)) {
      throw ArgumentError(
          "Dependency of type ${descOf<T>(tag: tag)} is already defined");
    }
    _container[key] = provider;
  }
}
