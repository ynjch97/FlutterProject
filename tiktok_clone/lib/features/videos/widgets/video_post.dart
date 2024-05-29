import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  const VideoPost({super.key, required this.onVideoFinished});

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  // VideoPlayerController 사용 시, 초기화 작업을 해주어야 영상을 불러올 수 있음
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video01.mp4");

  void _onVideoChange() {
    // 초기화 되었는지
    if (_videoPlayerController.value.isInitialized) {
      // 영상 길이가 현재 영상 내 위치와 같은지
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 초기화
    _videoPlayerController.play(); // 재생
    setState(() {});

    // 영상이 끝났는지 확인하기 위한 Listener
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill : 화면 전체를 채움
        Positioned.fill(
          // 초기화 되었으면 video 를 재생, 아니면 검은 화면
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
        ),
      ],
    );
  }
}
