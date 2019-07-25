import 'package:flutter/material.dart';


final animation = Tween(begin: 0, end: 2 * 3.14).animate(null);

var a = AnimatedBuilder(
  animation: animation,
  child: FlutterLogo(),
  builder: (context, child) {
    return Transform.rotate(
      angle: animation.value,
      child: child,
    );
  },
);

class AnimatedBuilderDemo extends StatefulWidget {
  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
