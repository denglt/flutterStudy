import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestUI extends StatefulWidget {
  @override
  _TestUIState createState() => _TestUIState();
}

class _TestUIState extends State<TestUI> {
  String _groupValue = '升压';
  int _blood = 1;
  String _sex = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test UI'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RadioListTile<String>(
              value: '升压',
              title: Text('升压'),
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
              },
            ),
            RadioListTile<String>(
              value: '升降压',
              title: Text('升降压'),
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
              },
            ),
            RadioListTile<String>(
              value: '降压',
              title: Text('降压'),
              groupValue: _groupValue,
              onChanged: (value) {
                setState(() {
                  _groupValue = value;
                });
              },
            ),
            RaisedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('你选择的是$_groupValue'),
                );
                print(context.widget);
                Scaffold.of(context).showSnackBar(snackBar);
                // Scaffold.of(context)
              },
              child: Text('确定'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('男'),
                    value: '男',
                    groupValue: _sex,
                    onChanged: (t) {
                      print(t);
                      _sex = t;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('女'),
                    value: '女',
                    groupValue: _sex,
                    onChanged: (t) {
                      print(t);
                      _sex = t;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
