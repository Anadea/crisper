import 'package:flutter/material.dart';

import 'mvvm.dart';
import 'home_view_model.dart';

class HomeScreen extends View<HomeViewModel> {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createViewState(HomeViewModel viewModel) =>
      _HomeScreenState(viewModel);
}

class _HomeScreenState extends ViewState<HomeScreen, HomeViewModel> {
  _HomeScreenState(HomeViewModel viewModel) : super(viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have pushed the button this many times:'),
            ValueListenableBuilder(
                valueListenable: viewModel.counter,
                builder: (context, counter, child) => Text("$counter",
                    style: Theme.of(context).textTheme.display1))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.plusButtonPressed,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
