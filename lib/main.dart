import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoLikeDislikeScreen(),
    );
  }
}

class VideoLikeDislikeScreen extends StatefulWidget {
  @override
  _VideoLikeDislikeScreenState createState() => _VideoLikeDislikeScreenState();
}

class _VideoLikeDislikeScreenState extends State<VideoLikeDislikeScreen> {
  late VideoPlayerController _controller;
  bool _isLiked = false;
  bool _isDisliked = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://youtu.be/yxif9Tj8fDE?si=K4v9FajYNt-ULjt1',
    )
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      if (_isLiked) _isDisliked = false;
    });
  }

  void _toggleDislike() {
    setState(() {
      _isDisliked = !_isDisliked;
      if (_isDisliked) _isLiked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player with Like/Dislike'),
      ),
      body: Column(
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: _isLiked ? Colors.blue : Colors.grey,
                ),
                onPressed: _toggleLike,
              ),
              IconButton(
                icon: Icon(
                  Icons.thumb_down,
                  color: _isDisliked ? Colors.red : Colors.grey,
                ),
                onPressed: _toggleDislike,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Like: $_isLiked, Dislike: $_isDisliked',
            style: TextStyle(fontSize: 20),
          ),
        ],
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
}
