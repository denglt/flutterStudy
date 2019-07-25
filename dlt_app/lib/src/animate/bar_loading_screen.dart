import 'package:flutter/material.dart';
import 'package:flutter/src/scheduler/ticker.dart';

class BarLoadingScreen extends StatefulWidget {
  @override
  _BarLoadingScreenState createState() => new _BarLoadingScreenState();
}

class _BarLoadingScreenState extends State<BarLoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  //Animation对象有状态。可以通过访问其value属性获取动画的当前值。
  //Animation对象本身和UI渲染没有任何关系。
  Animation<Color> animation;
  Animation<double> angle;
  CurvedAnimation curvedAnimation;

  Tween<double> tween;
  @override
  void initState() {
    super.initState();
    // Because this class has now mixed in a TickerProvider
    // It can be its own vsync. This is what you need almost always
    _controller = new AnimationController(
      duration: const Duration(microseconds: 3000), // 运行时间
      vsync: this,
    );

    // A tween that begins at grey and ends at a green
    // The chained 'animate' function is required
    animation = new ColorTween(
      begin: const Color.fromRGBO(10, 10, 10, 0.5),
      end: const Color.fromRGBO(0, 200, 100, 0.5),
    ).animate(_controller)
      ..addListener(() {
        // print(' ${DateTime.now()}____ColorTween');
        // print(animation.value);
        setState(() {});
      })
      ..addStatusListener((listener) { // 动画状态监控
        print(listener);
      });
    //tween = new Tween<double>(begin: 0.0, end: 1.00);

    _controller2 = new AnimationController(
      duration: const Duration(minutes: 1), // 运行时间
      vsync: _MyTick(),
    );
    angle = Tween<double>(begin: 0, end: 3.14).animate(_controller2); // 控制倾斜度
    curvedAnimation = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeIn,
    );

    _controller2.repeat();
    // Tell the animation to start
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: new Container(
        decoration: new BoxDecoration(color: animation.value),
        child: new Center(
          child: Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new _Bar(),
                  new _Bar(),
                  new _Bar(),
                  new _Bar(),
                ],
              ),
              Divider(),
              _newBar(0),
              Divider(),
              _newBar(1),
              Divider(),
              _newBar(2),
              Divider(),
              _newBar(3),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _newBar(0),
                  _newBar(1),
                  _newBar(2),
                  _newBar(3),
                ],
              ),
              Divider(),
              _newCurveBar(),
            ],
          ),
        ),
      ),
    );
  }

  // This is important for perf. When the widget is gone, remove the controller.
  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _newBar(int index) {
    return AnimatedBuilder(
      animation: _controller2,
      child: _Bar(),
      builder: (context, child) {
        //  print('____bar()');
        //  print(angle.value);
        return Transform.rotate(
          angle: angle.value + index * 3.14 / 4,
          child: child,
        );
      },
    );
  }

  Widget _newCurveBar() {
    return AnimatedBuilder(
      animation: _controller2,
      child: _Bar(),
      builder: (context, child) {
        //  print(curvedAnimation.value);
        return Transform.rotate(
          angle: curvedAnimation.value,
          child: child,
        );
      },
    );
  }
}

class _Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 35.0,
      height: 15.0,
      decoration: new BoxDecoration(
          color: const Color.fromRGBO(0, 0, 255, 1.0),
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: new Offset(1.0, 0.0),
            ),
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              spreadRadius: 1.5,
              offset: new Offset(1.0, 0.0),
            ),
          ]),
    );
  }
}

class _MyTick extends TickerProvider {
  @override
  Ticker createTicker(onTick) {
    return Ticker(onTick);
  }
}
