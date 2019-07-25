import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class PicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 means normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return _DetailScreen();
          }));
        },
        onHorizontalDragUpdate: (details) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return _DetailScreen();
          }));
        },
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              'https://picsum.photos/250?image=1',
              //fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Column(
            children: <Widget>[
              Transform.scale(
                scale: 0.5,
                child: Center(
                  child: Hero(
                    tag: 'imageHero',
                    child: Image.network(
                      'https://picsum.photos/250?image=1',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(50, 50),
                child: Center(
                  child: Hero(
                    tag: 'imageHero2',
                    child: Image.network(
                      'https://picsum.photos/250?image=1',
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.skewX(0.3),
                child: Image.asset('images/pic0.jpg'),
              )
            ],
          )),
    );
  }
}
