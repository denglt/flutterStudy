import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'counter_top.dart';
import 'bloc_provider.dart';
import 'counter_bloc.dart';

class MainBlocCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(    
      state: AppBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(   // 多个BlocProvier， 所以StoreProvider 也是可以有多个的
          state: CounterBLoc(),
          child: TopCounter(),
        ),
      ),
    );
  }
}
