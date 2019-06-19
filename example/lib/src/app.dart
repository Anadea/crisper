import 'package:flutter/material.dart';
import 'package:crisper/crisper.dart';

import 'presentation/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: get(tag: "appTitle"),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
