import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class PlayVideo extends StatefulWidget {
  final String url;
  PlayVideo({@required this.url});

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  VideoPlayerController _controller;

  @override
  void initState() {
    print('_PlayVideoState -> initState');
    super.initState();
    print('url -> ${widget.url} ');

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        print('VideoPlayerController initialize ok');
        setState(() {});
      }, onError: (e) {
        print('错误 ->');
        print(e);
      });
    _controller.addListener(() {
      if (_controller.value.hasError) {
        print(_controller.value.errorDescription);
      }
    });
    _controller.setLooping(true);
    _controller.play();

    print('_PlayVideoState -> end initState');
  }

  @override
  Widget build(BuildContext context) {
    print('_PlayVideoState -> build');
    print('_controller.value :' + _controller.value.runtimeType.toString());
    print(_controller.value.initialized);
    return Scaffold(
      appBar: AppBar(
        title: null,
        leading: null,
        actions: <Widget>[],
        bottom: null,
      ),
      body: Center(
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(
                child: _controller.value.hasError ? Text('视频无法打开！') : null,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    print('_PlayVideoState -> dispose');
    super.dispose();
    _controller.dispose();
  }
}
