import 'package:flutter/material.dart';

class ScaffoldStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: <Widget>[],
      ),
      body: null,
    );
  }
}

class ScaffoldStateful extends StatefulWidget {
  @override
  ScaffoldStatefulState createState() => ScaffoldStatefulState();
}

class ScaffoldStatefulState extends State<ScaffoldStateful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: null,
        actions: <Widget>[],
        bottom: null,
      ),
      body: null,
    );
  }
}

class TemplateIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.layers),
      tooltip: '****',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return ScaffoldStateless();
    }));
  }
}
