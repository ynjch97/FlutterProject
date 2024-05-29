import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  // VideoPlayerController 사용 시, 초기화 작업을 해주어야 영상을 불러올 수 있음
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video01.mp4");

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); // 초기화
    // _videoPlayerController.play(); // 자동 재생 X
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

  // Widget 이 다 보이는데, 동영상이 재생 중이 아니면 재생하기
  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  // 재생 중이면 일시정지, 일시정지면 재생
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
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
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          const Positioned.fill(
            // 클릭 이벤트를 무시하도록 함 (위의 _onTogglePause 가 먹도록)
            child: IgnorePointer(
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: Sizes.size52,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
