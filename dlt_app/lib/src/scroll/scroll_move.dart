import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollMove extends StatefulWidget {
  @override
  _ScrollMoveState createState() => _ScrollMoveState();
}

class _ScrollMoveState extends State<ScrollMove> {
  final _itemSize = 50.0;
  ScrollController _controller;

  void _moveUp() {
    if (_controller.offset > _controller.position.minScrollExtent) {
      //_controller.jumpTo(_controller.offset - _itemSize);
      _controller.animateTo(_controller.offset - _itemSize,
          curve: Curves.linear, duration: Duration(milliseconds: 500));
    }
  }

  void _moveDown() {
    if (_controller.offset < _controller.position.maxScrollExtent) {
      // _controller.jumpTo(_controller.offset + _itemSize);
      _controller.animateTo(_controller.offset + _itemSize,
          curve: Curves.linear, duration: Duration(milliseconds: 500));
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Movement"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("up"),
                    onPressed: _moveUp,
                  ),
                  RaisedButton(
                    child: Text("down"),
                    onPressed: _moveDown,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: 30,
              itemExtent: _itemSize,
              itemBuilder: (context, index) {
                return ListTile(title: Text("Index : $index"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
