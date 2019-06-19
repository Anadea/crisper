import 'package:flutter/material.dart';
import 'package:crisper/crisper.dart';
import '../di/di.dart' as Injector;

abstract class View<VM extends ViewModel> extends StatefulWidget {
  View({Key key}) : super(key: key);

  @override
  @mustCallSuper
  State createState() {
    Injector.initScopeOf(runtimeType);
    return createViewState(get<VM>(scope: runtimeType));
  }

  State createViewState(VM viewModel);
}

abstract class ViewState<V extends View, VM extends ViewModel>
    extends State<V> {
  @protected
  final VM viewModel;

  ViewState(this.viewModel)
      : assert(viewModel != null),
        super();

  @override
  @mustCallSuper
  void dispose() {
    viewModel.dispose();
    Injector.resetScopeOf(widget.runtimeType);
    super.dispose();
  }
}

abstract class ViewModel {
  void dispose();
}
