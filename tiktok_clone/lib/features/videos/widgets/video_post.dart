// ignore_for_file: slash_for_doc_comments

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

/**With ~Mixin : 해당 클래스를 복사해오겠다는 의미 
 * vsync : 불필요한 리소스 사용을 방지 (위젯이 안보일 때는 애니메이션이 작동하지 않음)
 * SingleTickerProviderStateMixin : 매 프레임마다 callback 을 호출
 * - 단, 위젯이 화면에 있을 때만 작동함
 */
class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // VideoPlayerController 사용 시, 초기화 작업을 해주어야 영상을 불러올 수 있음
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video01.mp4");

  late final AnimationController _animationController;

  final Duration _animationDuration = const Duration(milliseconds: 200);
  bool _isPaused = false;

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

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0, // 크기 지정
      upperBound: 1.5, // 크기 지정
      value: 1.5, // default 크기
      duration: _animationDuration,
    );

    /**_animationController.reverse()
     * 수행 시, 1.5 => 1.0 으로 값이 바뀌게 되는데,
     * build() 는 1.5, 1.0 일 때만 재수행 되고 있음
     * build() 가 값이 바뀌는 것을 알게 하려면? _animationController 에 이벤트 리스너 추가
     * 모든 단계에서 build 메서드를 실행하기 위해 이벤트 리스너에 setState() 추가
     */
    // _animationController.addListener(() {
    //   setState(() {});
    // });
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
      _animationController.reverse(); // lowerBound
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // upperBound
    }
    setState(() {
      _isPaused = !_isPaused;
    });
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
          Positioned.fill(
            // 클릭 이벤트를 무시하도록 함 (위의 _onTogglePause 가 먹도록)
            child: IgnorePointer(
              child: Center(
                // 사이즈 조절을 위해 AnimationController 사용
                child: AnimatedBuilder(
                  animation: _animationController,
                  // AnimatedBuilder 가 애니메이션의 변화를 감지하고, builder 가 최신 값으로 return 하도록 함
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  // Animated Widget 을 사용
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
