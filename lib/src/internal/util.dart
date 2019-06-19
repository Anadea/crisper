// Copyright 2019 Anadea Inc. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Used by the library to create a string key for the type [T]
/// tagged with [tag].
String keyOf(Type type, {String tag}) {
  if (type == null || type == dynamic) {
    throw ArgumentError("Unable to infer the type [$type]");
  }
  return "[$type]${tag == null ? "" : "::[$tag]"}";
}

/// Used by the library to create a description for the type [T]
/// tagged with [tag] and scoped by [scope]
String descOf<T>({Type scope, String tag}) =>
    "[$T]${tag == null ? "" : " tagged with [$tag]"}"
    "${scope == null ? "" : " scoped by [$scope]"}";

/// Throws an [ArgumentError] if the [reference] is `null`.
/// Otherwise, returns the [reference]
T checkNotNull<T>(T reference, [String message]) {
  if (reference == null) throw ArgumentError(message ?? "Must not be null");
  return reference;
}
