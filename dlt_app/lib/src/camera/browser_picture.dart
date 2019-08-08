import 'package:flutter/material.dart';
import 'dart:io';

class BrowserPicture extends StatefulWidget {
  final String path;

  BrowserPicture({this.path});

  @override
  _BrowserPictureState createState() => _BrowserPictureState();
}

class _BrowserPictureState extends State<BrowserPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pictures'),
      ),
      body: FutureBuilder(
        future: _buildGridTileList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            print('snapshot.data - > ${snapshot.data}');
            return GridView.count(
              crossAxisCount: 2, // specify the number of columns
              padding: const EdgeInsets.all(4),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: snapshot.data,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Widget>> _buildGridTileList() async {
    List<Widget> widgets = [];
    if (await FileSystemEntity.isDirectory(widget.path)) {
      final startingDir = Directory(widget.path);
      await for (var entity
          in startingDir.list(recursive: false, followLinks: false)) {
        print('find -> $entity');
        if (entity is File && entity.path.endsWith(".png")) {
          print('find png -> $entity');
          widgets.add(
            Container(
              child: Image.file(entity),
            ),
          );
        }
      }
    } else {
      print("is not dir");
      widgets.add(Text(' ${widget.path} is not dir'));
    }
    if (widgets.length == 0) {
      widgets.add(
        Center(
          child: Text('not find png.'),
        ),
      );
    }
    return widgets;
  }
}
