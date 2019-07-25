import 'package:flutter/material.dart';

class Pvalova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strawberry Pavlova Recipe'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 40, 0, 30), //边距
          height: 600,
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 414,
                  child: _leftColumn,
                ),
                _mainImage,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final _titleText = Container(
  padding: EdgeInsets.all(20),
  child: Text(
    'Strawberry Pavlova',
    style: TextStyle(
      fontWeight: FontWeight.w800,
      letterSpacing: 0.5,
      fontSize: 30,
    ),
  ),
);

final _subTitle = Text(
  'Pavlova is a meringue-based dessert named after the Russian ballerina '
  'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
  'topped with fruit and whipped cream.',
  textAlign: TextAlign.center,
  style: TextStyle(
    fontFamily: 'Georgia',
    fontSize: 25,
  ),
);

Widget _stars = Row(
  mainAxisSize: MainAxisSize.min,
  //mainAxisAlignment: MainAxisAlignment.center, // spaceEvenly
  children: <Widget>[
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
);

Widget _ratings = Container(
  padding: EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _stars,
      Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);

final _descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

// DefaultTextStyle.merge() allows you to create a default text
// style that is inherited by its child and all subsequent children.
final _iconList = DefaultTextStyle.merge(
  style: _descTextStyle,
  child: Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Icon(Icons.kitchen, color: Colors.green[500]),
            Text('PREP:'),
            Text('25 min'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.timer, color: Colors.green[500]),
            Text('COOK:'),
            Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            Text('FEEDS:'),
            Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);

final _leftColumn = Container(
  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: [
      _titleText,
      _subTitle,
      _ratings,
      _iconList,
    ],
  ),
);

final _mainImage = Image.asset(
  'images/pavlova.jpg',
  fit: BoxFit.cover,
);
