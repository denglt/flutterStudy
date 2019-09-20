import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'counter_main.dart';

class UnderCounter extends StatefulWidget {
  @override
  _UnderCounterState createState() => _UnderCounterState();
}

class _UnderCounterState extends State<UnderCounter> {
  @override
  Widget build(BuildContext context) {
    print('_UnderCounterState -> $context');
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CountState, int>(
              converter: (store) => store.state.count,
              builder: (context, count) {
                return Text(
                  count.toString(),
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback>(//转换state为一个VoidCallback
        converter: (store) {
          return () => store.dispatch(CountAction.increment);// 发出了一个动作，所以是VoidCallback。
        },
        builder: (context, callback) { //这个callback为上面的VoidCallback
          return FloatingActionButton(
            onPressed: callback,
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
