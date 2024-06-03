import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // 사용자가 스크롤할 수 있는 특정한 sliver widget 목록을 넣음
      slivers: [
        SliverAppBar(
          // SliverAppBar 가 숨겨지거나 보여지는 방식
          snap: true, // 살짝만 올라가도 appbar 전체가 바로 보여짐
          floating: true, // 스크롤을 내렸다가 올라가면 다시 보여짐
          stretch: true,
          pinned: true, // FlexibleSpaceBar 를 볼 수 있게 유지
          backgroundColor: Theme.of(context).primaryColor,
          // 화면을 쓸어올리면 80px까지 줄어들었다가 사라짐
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: const FlexibleSpaceBar(
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
            ],
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50, // 50개 제한
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100, // item 의 height
        ),
      ],
    );
  }
}
