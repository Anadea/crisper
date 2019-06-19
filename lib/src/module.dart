// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'binder.dart';

/// Represents class that contributes to the dependency injection container
/// Сan be used as an interface.
abstract class Module {
  /// Used for configuring module contributions
  void setup(Binder binder);
}