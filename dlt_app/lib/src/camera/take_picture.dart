import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'browser_picture.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  // Obtain a list of the available cameras on the device.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<CameraDescription> _cameras;
  CameraDescription _selectedCamera;
  CameraController _controller;
  String _hint;
  String _lastPictureFilePath;

  @override
  void initState() {
    super.initState();
    _initCarames();
  }

  void _initCarames() {
    try {
      availableCameras().then((cameras) {
        _cameras = cameras;
        if (_cameras.length > 0) {
          _startCamera(_cameras[0]);
        } else {
          setState(() {
            _hint = 'no find camera !';
          });
        }
      });
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _startCamera(CameraDescription cameraDescription) async {
    await _controller?.dispose();
    _selectedCamera = cameraDescription;
    _controller = CameraController(
      _selectedCamera,
      ResolutionPreset.medium,
    );
    _controller.initialize().then((_) {
      setState(() {
        _hint = null;
      });
    }, onError: (e) {
      setState(() {
        _hint = '请授权摄像头权限！';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Camera'),
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
                  child: _cameraPreviewScreen(),
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
    );
  }

  Widget _cameraPreviewScreen() {
    if (_hint != null)
      return Center(
        child: Text(
          _hint,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    else {
      return _controller != null && _controller.value.isInitialized
          ? _cameraPreviewWidget(_controller)
          : Center(
              child: CircularProgressIndicator(),
            );
    }
  }

  Widget _cameraPreviewWidget(CameraController controller) {
    Widget doublePic() {
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          CameraPreview(controller),
          CircleAvatar(
            child: CameraPreview(controller),
            backgroundColor: Colors.black,
            radius: 50,
          )
        ],
      );
    }

    if (_lastPictureFilePath == null) {
      return doublePic();
    } else
      return Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          doublePic(),
          CircleAvatar(
            backgroundImage: FileImage(File(_lastPictureFilePath)),
            backgroundColor: Colors.black,
            radius: 50,
          ),
        ],
      );
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
              ? _onStartVideoButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: _controller != null &&
                  _controller.value.isInitialized &&
                  _controller.value.isRecordingVideo
              ? _onStopVideoButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.switch_camera),
          color: Colors.blue,
          onPressed: _cameras != null && _cameras.length > 1
              ? _onSwitchCameraButtonPressed
              : null,
        ),
      ],
    );
  }

  void _onTakePictureButtonPressed() async {
    final filePath = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    try {
      await _controller.takePicture(filePath);
      _showInSnackBar('Picture saved to $filePath');
      _lastPictureFilePath = filePath;
      setState(() {});
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _onStartVideoButtonPressed() async {
    final filePath = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.mp4',
    );
    try {
      await _controller.startVideoRecording(filePath);
      setState(() {});
      _showInSnackBar('Saving video to $filePath');
      //setState(() {});
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _onStopVideoButtonPressed() async {
    try {
      await _controller.stopVideoRecording();
      setState(() {});
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _onSwitchCameraButtonPressed() {
    _selectedCamera =
        _cameras.firstWhere((e) => e != _selectedCamera, orElse: () => null);
    _startCamera(_selectedCamera);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  void _showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void _showCameraException(CameraException e) {
    //logError(e.code, e.description);
    _showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}
