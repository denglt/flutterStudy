import 'package:dlt_app/src/state_manage/bloc/bloc_provider.dart';
import 'package:dlt_app/src/state_manage/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'counter_under.dart';

class TopCounter extends StatefulWidget {
  @override
  _TopCounterState createState() => _TopCounterState();
}

class _TopCounterState extends State<TopCounter> {
  @override
  Widget build(BuildContext context) {
    print('_TopCounterState -> $context');
    AppBloc appBloc = BlocProvider.of(context);
    print('find => $appBloc ');
    CounterBLoc counterBLoc = BlocProvider.of(context);
    print('find => $counterBLoc');
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop();
          },
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: counterBLoc.stream,
          initialData: counterBLoc.value,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            print('StreamBuilder.builder => $context');
            return Text(
              'You hit me: ${snapshot.data} times',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('onPressed -> _TopCounterState -> $context');
          print('onPressed -> _TopCounterState -> ${context.runtimeType}');
          print('onPressed -> _TopCounterState -> ${context.widget}');

          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              print('MaterialPageRoute -> $context');
              print('MaterialPageRoute -> ${context.runtimeType}');
              print('MaterialPageRoute -> ${context.widget.runtimeType}');
              return UnderCounter(counterBLoc);
            },
            maintainState: false,
          ));
        },
        child: Icon(Icons.forward),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("Dependencies change");
  }
}
