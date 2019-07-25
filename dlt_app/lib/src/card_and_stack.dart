import 'package:flutter/material.dart';

class CardAndStack extends StatelessWidget {
  final bool showCard;

  CardAndStack({@required this.showCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card And Stack'),
      ),
      body: Center(
        child: showCard
            ? _buildCard()
            : Column(
                children: <Widget>[
                  _image,
                  _buildStack(),
                ],
              ),
      ),
    );
  }

  // #docregion Card
  Widget _buildCard() => SizedBox(
        height: 210,
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('1625 Main Street',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                subtitle: Text('My City, CA 99984'),
                leading: Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('(408) 555-1212',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              ListTile(
                title: Text('costa@example.com'),
                leading: Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      );
  // #enddocregion Card

  final Widget _image = Image.asset('images/pic0.jpg');

  // #docregion Stack
  Widget _buildStack() => Stack(
        alignment:const Alignment(0.6, 0.6), // AlignmentDirectional.bottomEnd  ,//const Alignment(0.6, 0.6),
        children: [
          _image,
          CircleAvatar(
            backgroundImage: AssetImage('images/pic0.jpg'),
            radius: 50,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
            ),
            child: Text(
              'Mia B',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          
        ],
      );
  // #enddocregion Stack
}
