import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File _image;

  void _takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    /*
     image 并不会保存到系统相册中，
     可以使用 image_gallery_saver 或 image_picker_saver 保存到系统相册
     */
    await ImageGallerySaver.save(image.readAsBytesSync());
    print(' take Photo -> $image');
    setState(() {
      _image = image;
    });
  }

  void _selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
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
        title: Text('Image Picker Example'),
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
