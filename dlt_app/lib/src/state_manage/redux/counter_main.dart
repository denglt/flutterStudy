import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'counter_top.dart';

// https://github.com/brianegan/flutter_redux
@immutable
class CountState {
  final int _count;
  get count => _count;
  CountState(this._count);

  CountState.initState() : _count = 0;
}

enum Action { increment }

/*
 * reducer会根据传进来的action生成新的CountState
 */
CountState reducer(CountState state, action) {
  //匹配Action
  if (action == Action.increment) {
    return CountState(state.count + 1);
  }
  return state;
}

Reducer<CountState> reducers = combineReducers<CountState>([
  reducer,
 // TypedReducer(reducer), //a class may be preferred to a function
]);

// Redux把所有状态存到一起有些臃肿，也会存在UI不必要的刷新，这在App上需要尽量避免
class MainCounter extends StatelessWidget {
  final _store = Store<CountState>(
    reducers,
    initialState: CountState.initState(),
    middleware: [LoggingMiddleware.printer()],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider(  //建议一个app仅有一个Store，位于app最顶层，所有组件都共享该Store
                           //但是是可以有多个StoreProvider的
      store: _store,
      child: MaterialApp(   //这儿把MaterialApp作为一个Module用，并有自己的Navigator
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: TopCounter()),
    );
  }
}
