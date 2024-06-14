// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  static const routeURL = Routes.videoTimelineScreen;
  static const routeName = RoutesName.videoTimelineScreen;

  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  @override
  void dispose() {
    // Controller dispose 를 해주어야 함
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    // 애니메이션과 함께 페이지 이동
    _pageController.animateToPage(
      page, // 현재 페이지 파라미터
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      setState(() {});
    }
  }

  /**영상이 끝날 때 다음 화면으로 넘기는 애니메이션
   * 영상이 끝나면 호출되어, 다음 영상으로 넘어갈 것임
   * 영상이 끝났는지는 VideoPost() 안에서 확인 가능
   */
  void _onVideoFinished() {
    // 자동으로 다음 영상으로 넘어가도록 처리했다가 막음 (7.8 Video UI)
    return;

    // 현재 페이지 파라미터를 알려주는 방식
    /*
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    */
    // 페이지 파라미터 없이 다음 페이지로 넘기는 방식
    /*
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    */
  }

  Future<void> _onRefresh() {
    // 새로고침 시 3초간 sleep 한다고 가정
    return Future.delayed(
      const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load videos: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          // Scaffold 안에서 렌더링 되고 있으므로 바로 Widget 사용
          // RefreshIndicator : 당겨서 타임라인을 새로고침할 때 사용
          data: (videos) => RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 50, // 화면을 당긴 후 indicator 돌아갈 위치
            edgeOffset: 20, // 어디에서 부터 시작할 것인지
            color: Theme.of(context).primaryColor,
            // PageView.builder : itemBuilder 를 이용해 필요한 만큼만 렌더링
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) =>
                  VideoPost(onVideoFinished: _onVideoFinished, index: index),
            ),
          ),
        );
  }
}
