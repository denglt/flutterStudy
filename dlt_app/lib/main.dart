import 'package:dlt_app/src/my_layout.dart';
import 'package:flutter/material.dart';
import 'src/random_words.dart';
import 'src/my_scaffold.dart';
import 'src/counter.dart';
import 'src/shop.dart';

class RandoomWordsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('MyButton was tapped!');
        _pushRandomWords(context);
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('RandomWords'),
        ),
      ),
    );
  }

  void _pushRandomWords(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return RandomWords();
    }));
  }
}

class ShippingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      tooltip: 'shopping',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return ShoppingList(
        products: <Product>[
          Product(name: 'Eggs'),
          Product(name: 'Flour'),
          Product(name: 'Chocolate chips'),
        ],
      );
    }));
  }
}

class MyLayoutButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.layers),
      tooltip: 'shopping',
      onPressed: () => _onPressed(context),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return MyLayout();
    }));
  }
}

class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: () => _pushMyScaffold(context),
        ),
        title: Text('Example title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
          RandoomWordsButton(),
        ],
      ),
      // body is the majority of the screen.
      body: Center(
        child: Column(
          children: <Widget>[
            RandoomWordsButton(),
            Counter(),
            ShippingButton(),
            MyLayoutButton(),
          ],
          textDirection: TextDirection.rtl,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add', // used by assistive technologies
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }

  void _pushMyScaffold(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return MyScaffold();
    }));
  }
}

main(List<String> args) {
  //_titleSection
  runApp(MaterialApp(
    title: 'My app',
    home: TutorialHome(), //MyScaffold(),
  ));
}
