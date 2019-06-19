import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/di/di.dart';

void main() {
  initInjector();
  runApp(App());
}
