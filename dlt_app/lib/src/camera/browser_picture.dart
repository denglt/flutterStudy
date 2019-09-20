import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class BrowserPicture extends StatefulWidget {
  final String path;
  final bool showImage;
  BrowserPicture({this.path, this.showImage = true});

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
        future: _buildGridViewImage(),
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

  Future<List<Widget>> _buildGridViewImage() async {
    List<Widget> widgets = [];
    if (await FileSystemEntity.isDirectory(widget.path)) {
      final startingDir = Directory(widget.path);
      await for (var entity
          in startingDir.list(recursive: false, followLinks: false)) {
        if (entity is File &&
            (entity.path.endsWith(".jpg") || entity.path.endsWith(".png"))) {
          List<int> compressImage = await FlutterImageCompress.compressWithFile(
            entity.absolute.path,
            quality: 50,
            rotate: 0,
          );
          print(
              'file:$entity size: ${entity.lengthSync()}, ${compressImage.length}');
          widgets.add(
            Container(
              child: widget.showImage
                  ? /* FadeInImage(
                      image: FileImage(entity),
                      placeholder: MemoryImage(compressImage),
                    ) */
                  MemoryImage(Uint8List.fromList(compressImage))
                  : Text('file:$entity size: ${entity.lengthSync()}'),
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
          child: Text('not find images.'),
        ),
      );
    }
    return widgets;
  }
}
