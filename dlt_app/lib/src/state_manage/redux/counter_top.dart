import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'counter_main.dart';
import 'counter_under.dart';

class TopCounter extends StatefulWidget {
  @override
  _TopCounterState createState() => _TopCounterState();
}

class _TopCounterState extends State<TopCounter> {
  @override
  Widget build(BuildContext context) {
    print('_TopCounterState -> $context');
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(
              context,
              rootNavigator: true, // 获取顶层的Navigator
            ).pop();
          },
        ),
      ),
      body: Center(
        child: StoreConnector<CountState, int>(
          converter: (store) => store.state.count,
          builder: (context, count) {
            return Text(
              count.toString(),
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('onPressed _TopCounterState -> $context');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              print('MaterialPageRoute -> $context');
              return UnderCounter();
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
