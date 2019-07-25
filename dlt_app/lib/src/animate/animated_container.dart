import 'package:flutter/material.dart';

class AnimatedContainerSample extends StatefulWidget {
  @override
  _AnimatedContainerSampleState createState() =>
      _AnimatedContainerSampleState();
}

class _AnimatedContainerSampleState extends State<AnimatedContainerSample> {
  String _text = 'text';
  Color _color2 = Colors.red;

  @override
  Widget build(BuildContext context) {
    final _rectangle = Center(
      child: AnimatedContainer(
        duration: duration == null ? animationDuration : duration,
        curve: _curve,
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          color: _color,
          shape: _shape,
          border: Border.all(width: _border),
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                setState(() {
                  _color2 = _color2 == Colors.blue ? Colors.red : Colors.blue;
                  _text = 'denglt';

                  duration = animationDuration;
                  _height = _height == 250.0 ? 150.0 : 250.0;

                  _border = _border == 10.0 ? 2.0 : 10.0;
                  _opacity = _opacity == 0.50 ? 0.25 : 0.50;
                  _image = 'https://picsum.photos/250?image=1';
                });
                setState(() {
                  _angle = 3.14 ;
                });
              },
            )
          ],
        ),
        body: Transform.rotate(
          angle: _angle,
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                height: 150,
                color: _color2,
                duration: const Duration(seconds: 2),
                curve: Curves.bounceIn,
                child: Center(
                  child: Text(_text),
                ),
              ),
              Divider(),
              AnimatedOpacity(
                // 透明度
                opacity: _opacity,
                duration: animationDuration,
                child: _rectangle,
              ),
              Divider(),
              _rectangle,
              Divider(),
              Transform.rotate(
                angle: 3.14 / 4,
                child: FadeInImage.assetNetwork(
                  // 渐进图片
                  fadeInDuration: animationDuration,
                  fadeInCurve: Curves.bounceIn,
                  height: 150,
                  placeholder: 'images/pic0.jpg',
                  image: _image,
                ),
              )
            ],
          ),
        ));
  }

  final Duration animationDuration = Duration(seconds: 2);
  final Duration resetDuration = Duration(seconds: 1);
  double _height = 150.0;
  double _width = 150.0;
  ColorSwatch _color = Colors.redAccent;
  double _border = 2.0;
  BoxShape _shape = BoxShape.rectangle;
  Curve _curve = Curves.decelerate;
  Duration duration;
  double _opacity = 0.25;
  String _image = 'https://picsum.photos/250?image=9';
  double _angle = 0;
}
