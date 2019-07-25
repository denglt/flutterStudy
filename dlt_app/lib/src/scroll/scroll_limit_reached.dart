import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollLimitReached extends StatefulWidget {
  @override
  _ScrollLimitReachedState createState() => _ScrollLimitReachedState();
}

class _ScrollLimitReachedState extends State<ScrollLimitReached> {
  ScrollController _controller;
  String _message = 'scroll';
  int _itemCount = 30;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      String _old = _message;
      if (!_controller.position.outOfRange) {
        if (_controller.offset >= _controller.position.maxScrollExtent) {
          _message = "reach the bottom";
          print('加10');
          _itemCount = _itemCount + 10;
        } else if (_controller.offset <= _controller.position.minScrollExtent) {
          _message = "reach the top";
        } else {
          _message = "scrolling";
        }
      }
      if (_old != _message) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_ScrollLimitReachedState -> build');
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(_message),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller:
                  _controller, //这个controller控制了ListView内容的显示offset，所以就算重画也能真确显示scroll
              itemCount: _itemCount,
              //itemExtent: ,
              itemBuilder: (context, index) {
                print('item$index');
                return ListTile(title: Text("Index : $index"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
