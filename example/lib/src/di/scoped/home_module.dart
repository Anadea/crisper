import 'package:crisper/crisper.dart';

import '../../presentation/home_view_model.dart';

class HomeModule implements Module {
  @override
  void setup(Binder binder) {
    binder.bindsFactory(() => HomeViewModel(get()));
  }
}