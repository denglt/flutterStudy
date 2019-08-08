import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'browser_picture.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  // Obtain a list of the available cameras on the device.
  List<CameraDescription> _cameras;
  CameraDescription _camera;

  CameraController _controller;
  Future<void> _initializeControllerFuture;

  String _hint;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _cameras = cameras;
      print(_cameras.length);
      if (_cameras.length > 0) {
        _camera = _cameras.first;
        _controller = CameraController(
          _camera,
          ResolutionPreset.medium,
        );
        // Next, initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller.initialize();
        _initializeControllerFuture.catchError((e) {
          print('_controller.initialize => $e');
          setState(() {
            _hint = '请授权摄像头权限！';
          });
        });
        setState(() {});
      } else {
        setState(() {
          _hint = 'no find camera !';
        });
      }
    }, onError: (e) {
      print('error => $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('_cameras -> $_cameras');
    return Scaffold(
      appBar: AppBar(
        title: Text('take picture'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: () async {
              String _path = (await getTemporaryDirectory()).path;
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return BrowserPicture(
                      path: _path,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color:
                      _controller != null && _controller.value.isRecordingVideo
                          ? Colors.redAccent
                          : Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          _captureControlRowWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: _onTakePictureButtonPressed,
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    print('_initializeControllerFuture -> $_initializeControllerFuture');
    if (_hint != null)
      return Center(
        child: Text(_hint),
      );
    else {
      return FutureBuilder(
        future: _initializeControllerFuture,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          print('snapshot.connectionState -> ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    }
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: _controller != null &&
                  _controller.value.isInitialized &&
                  !_controller.value.isRecordingVideo
              ? _onTakePictureButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: _controller != null &&
                  _controller.value.isInitialized &&
                  !_controller.value.isRecordingVideo
              ? _onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: _controller != null &&
                  _controller.value.isInitialized &&
                  _controller.value.isRecordingVideo
              ? _onStopButtonPressed
              : null,
        )
      ],
    );
  }

  void _onTakePictureButtonPressed() async {
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      // await _controller.stopVideoRecording();
      await _controller.takePicture(path).then((_) {
        print('take picture ok !');
      }, onError: (e) {
        print('take picture error => $e');
      });
    } catch (e) {
      print(e);
    }
  }

  void _onVideoRecordButtonPressed() async {
    // await _controller.startVideoRecording(filePath)
  }

  void _onStopButtonPressed() async {}

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }
}
