import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
          MyBottom(),
        ],
      ),
    );
  }
}

class MyAppBar extends StatefulWidget {
  // This widget is the root of your application.
  MyAppBar({this.title});

  final Widget title;

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    print(this.context == context);
    return Container(
      height: 110.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Navigation menu',
            onPressed: _back,
          ),
          // Expanded expands its child to fill the available space
          Expanded(
            child: widget.title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }

  void _back() {
    print(Navigator.of(context).canPop());
    Navigator.of(context).pop();
    print(Navigator.of(context).canPop());
  }
}

class MyBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      child: Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(Icons.menu),
              tooltip: 'Navigation menu',
              onPressed: null,
              alignment: Alignment.topLeft,
            ),
            flex: 1,
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.search),
              tooltip: 'Search',
              onPressed: null,
              alignment: Alignment.topRight,
            ),
            flex: 1,
          ),

          // IconButton()
        ],
      ),
    );
  }
}
