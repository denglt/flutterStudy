import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'counter_bloc.dart';

class UnderCounter extends StatefulWidget {
  final CounterBLoc counterBLoc;
  UnderCounter(this.counterBLoc);
  @override
  _UnderCounterState createState() => _UnderCounterState();
}

class _UnderCounterState extends State<UnderCounter> {
  @override
  Widget build(BuildContext context) {
    print('_UnderCounterState -> $context');
    // CounterBLoc countBLoc = BlocProvider.of(context);
    //countBLoC.increment();
    return Scaffold(
      appBar: AppBar(
        title: Text('Under Screen'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget.counterBLoc.stream,
          initialData: widget.counterBLoc.value,
          builder: (context, snapshot) => Text(
                "You hit me: ${snapshot.data} times",
                style: Theme.of(context).textTheme.display1,
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.counterBLoc.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
