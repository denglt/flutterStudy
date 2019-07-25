import 'dart:async';

import 'bloc_provider.dart';

class CounterBLoc extends BlocBase {
  int _count;
  StreamController<int> _countController;

  CounterBLoc() {
    _count = 0;
    _countController = StreamController<int>.broadcast();
  }

  Stream<int> get stream => _countController.stream;

  int get value => _count;

  increment() {
    _countController.sink.add(++_count);
  }

  @override
  void dispose() {
    _countController.close();
  }
}

class AppBloc extends BlocBase {
  @override
  void dispose() {}
}
