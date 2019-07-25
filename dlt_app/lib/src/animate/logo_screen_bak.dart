import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    controller.view;
    animation = Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((state) {
        print("$state");
        if (state == AnimationStatus.completed) {
          print('completed');
          controller.reverse();
        }
        if (state == AnimationStatus.dismissed) {
          print('dismissed');
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      /*
      body: Center(
        child: new Container(
          margin: new EdgeInsets.symmetric(vertical: 10.0),
          height: animation.value,
          width: animation.value,
          child: new FlutterLogo(),
        ),
      ), */
      // body: _animatedLogo(),
      body: _AnimatedLogo(
        animation: animation,
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget _animatedLogo() {
    return AnimatedBuilder(
      animation: controller,
      child: null,
      builder: (context, child) {
        return Center(
          child: new Container(
            margin: new EdgeInsets.symmetric(vertical: 10.0),
            height: animation.value,
            width: animation.value,
            child: new FlutterLogo(),
          ),
        );
      },
    );
  }
}

// AnimatedWidget(基类)中会自动调用addListener()和setState()。
class _AnimatedLogo extends AnimatedWidget {
  _AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}
