// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

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
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    // Controller dispose 를 해주어야 함
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold 안에서 렌더링 되고 있으므로 바로 Widget 사용
    // PageView.builder : itemBuilder 를 이용해 필요한 만큼만 렌더링
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) =>
          VideoPost(onVideoFinished: _onVideoFinished, index: index),
    );
  }
}
