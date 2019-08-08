import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker_saver/image_picker_saver.dart';

class ImagePickerSaverPage extends StatefulWidget {
  @override
  _ImagePickerSaverPageState createState() => _ImagePickerSaverPageState();
}

class _ImagePickerSaverPageState extends State<ImagePickerSaverPage> {
  File _image;

  void _takeImage() async {
    File image = await ImagePickerSaver.pickImage(source: ImageSource.camera);
    ImagePickerSaver.saveFile(
      fileData: image.readAsBytesSync(),
      title: null,
      description: null,
    );
    print(' take Photo -> $image');
    setState(() {
      _image = image;
    });
  }

  void _selectImage() async {
    var image = await ImagePickerSaver.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(' select Photo -> $image');
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Saver Example'),
      ),
      body: Center(
        child: _image == null ? Text('No image selected.') : Image.file(_image),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /*
          FloatingActionButton(
            onPressed: _takeImage,
            tooltip: 'take Image',
            child: Icon(Icons.add_a_photo),
          ),
          */
          FloatingActionButton(
            onPressed: _selectImage,
            heroTag: 'image0',
            tooltip: 'Pick Image from gallery',
            child: const Icon(Icons.photo_library),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: _takeImage,
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.camera_alt),
            ),
          )
        ],
      ),
    );
  }
}
