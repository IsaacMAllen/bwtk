import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({Key? key}) : super(key: key);

  @override
  VideoAppState createState() => VideoAppState();
}

class VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  VideoPlayerController getConroller() {
    return _controller;
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('videos/promo.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized) {
      return
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller));
    }
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}