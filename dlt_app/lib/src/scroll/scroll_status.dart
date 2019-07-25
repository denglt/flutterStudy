import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScrollStatus extends StatefulWidget {
  @override
  _ScrollStatusState createState() => _ScrollStatusState();
}

class _ScrollStatusState extends State<ScrollStatus> {
  String _message = "";
  Widget _listView;
  @override
  void initState() {
    super.initState();
    _listView = _buildListView();
  }

  @override
  Widget build(BuildContext context) {
    // print('_ScrollStatusState -> build');
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Status"),
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
            child: _listView,
          ),
          Divider(),
          Expanded(
            child: _buildListView(),
          ),
          Divider(),
          Expanded(
            child: _buildPointerText(),
          ),
          Divider(),
          Expanded(
            child: _buildNotificationText(),
          ),
        ],
      ),
    );
  }

  _onStartScroll(ScrollMetrics metrics) {
    // print(metrics);
    // print('${metrics.minScrollExtent},${metrics.maxScrollExtent}, ${metrics.pixels}');
    setState(() {
      _message = "Scroll Start";
    });
  }

  _onUpdateScroll(ScrollMetrics metrics) {
    setState(() {
      _message = "Scroll Update";
    });
  }

  _onEndScroll(ScrollMetrics metrics) {
    // print(metrics);
    setState(() {
      _message = "Scroll End";
    });
  }

  Widget _buildListView() {
    // print('new NotificationListener');
    return NotificationListener<Notification>(
      child: ListView.builder(
        // key: GlobalKey(), //Key('denglt'),  控制组件的复用
        /* 重画的时候是怎样知道滚动的位置的???
           通过把旧组件状态应用到新组件,see:Widget.canUpdate, 用于判断Widget是否能复用, 注意类型相同, key为空也是可以复用的.
           这儿的key很重要，决定了组件能否复用
                       */
        controller: null,
        itemCount: 30,
        itemBuilder: (context, index) {
          return ListTile(title: Text("Index : $index"));
        },
      ),
      onNotification: (scrollNotification) {
        //type: ScrollStartNotification\UserScrollNotification\ScrollUpdateNotification\ScrollEndNotification
        if (scrollNotification is ScrollStartNotification) {
          _onStartScroll(scrollNotification.metrics);
        } else if (scrollNotification is ScrollUpdateNotification) {
          _onUpdateScroll(scrollNotification.metrics);
        } else if (scrollNotification is ScrollEndNotification) {
          _onEndScroll(scrollNotification.metrics);
        }
        print('Notification ->' + scrollNotification.runtimeType.toString());
      },
    );
  }

  Widget _buildNotificationText() {
    return NotificationListener<Notification>(
      child: Text('text'),
      onNotification: (notification) {
        print('Notification ->' + notification.runtimeType.toString());
      },
    );
  }

  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  Widget _buildPointerText() {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(300.0, 200.0)),
      child: Listener(
        child: Container(
          color: Colors.lightBlueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pointed at this box this many times:'),
              Text(
                '$_enterCounter Entries\n$_exitCounter Exits',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                'The cursor is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
              ),
            ],
          ),
        ),
        onPointerMove: _onPointerMove,
        onPointerEnter: _incrementCounter,
        onPointerHover: _updateLocation,
        onPointerExit: _decrementCounter,
      ),
    );
  }

  void _onPointerMove(PointerMoveEvent details) {
    print(details.runtimeType);
  }

  void _incrementCounter(PointerEnterEvent details) {
    setState(() {
      _enterCounter++;
    });
  }

  void _decrementCounter(PointerExitEvent details) {
    setState(() {
      _exitCounter++;
    });
  }

  void _updateLocation(PointerHoverEvent details) {
    setState(() {
      x = details.position.dx;
      y = details.position.dy;
    });
  }
}
