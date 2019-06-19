import 'package:crisper/crisper.dart';
import 'package:flutter/foundation.dart';

class CommonModule implements Module {
  @override
  void setup(Binder binder) {
    binder.bindsLazyInstance(() => "Example", tag: "appTitle");
    binder.bindsFactory(() => ValueNotifier<int>(0));
  }
}
