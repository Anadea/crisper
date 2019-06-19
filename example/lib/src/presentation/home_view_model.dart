import 'package:flutter/foundation.dart';

import 'mvvm.dart';

class HomeViewModel implements ViewModel {
  final ValueNotifier<int> _counter;

  HomeViewModel(this._counter);

  ValueListenable<int> get counter => _counter;

  void plusButtonPressed() => _counter.value = ++_counter.value;

  @override
  void dispose() {
    _counter.dispose();
  }
}
