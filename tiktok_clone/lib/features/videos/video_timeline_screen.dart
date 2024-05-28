import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    // 애니메이션과 함께 페이지 이동
    _pageController.animateToPage(
      page, // 현재 페이지 파라미터
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );

    if (page == colors.length - 1) {
      _itemCount = colors.length + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
      setState(() {});
    }
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
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index,\r\nitemCount $_itemCount",
            style: const TextStyle(fontSize: 38),
          ),
        ),
      ),
    );
  }
}
