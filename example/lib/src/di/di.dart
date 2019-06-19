library di;

import 'package:crisper/crisper.dart';

import 'general/common_module.dart';
import 'scoped/home_module.dart';

import '../presentation/home_screen.dart';

typedef _ModuleFactory = Module Function();

final Map<Type, _ModuleFactory> _scopedModules = {
  HomeScreen: () => HomeModule(),
// OtherScreen: () => OtherModule(),
};

void initInjector() => IoContainer.take().add(CommonModule());
// ..add(SomeModule());
// ..add(NextModule());

void initScopeOf(Type type) {
  _checkType(type);
  final moduleFactory = _scopedModules[type];
  if (moduleFactory == null) {
    throw ArgumentError(
        "The module that defines the scope of type [$type] not found");
  }

  IoContainer.take().add(moduleFactory(), scope: type);
}

void resetScopeOf(Type type) {
  _checkType(type);
  IoContainer.take().removeScope(type);
}

void _checkType(Type type) {
  if (type == null || type == dynamic) {
    throw ArgumentError("Unable initiate the scope of type [$type]");
  }
}
