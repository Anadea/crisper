// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A lightweight dependency injection container for Flutter and Dart
library crisper;

import 'package:crisper/src/iocontainer.dart' as Container;

export 'src/binder.dart';
export 'src/iocontainer.dart' show IoContainer;
export 'src/module.dart';

/// Returns type [T]
Type typeOf<T>() => T;

/// Resolves a dependency instance of type [T] tagged with [tag]
/// and scoped by [scope]
T get<T>({Type scope, String tag}) =>
    Container.retrieve<T>(scope: scope, tag: tag);
