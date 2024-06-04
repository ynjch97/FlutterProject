import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/stf_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../users/user_profile_screen.dart';
import 'widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 4;
  bool _isTapDown = false;

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record Video"),
          ),
        ),
        fullscreenDialog: true, // 전체 화면으로
      ),
    );

    setState(() {
      _isTapDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 화면을 가리지 않도록 default true 세팅되기 때문에 영상이 찌그러지므로 false
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(
              username: "YNJCH",
              tab: "",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        surfaceTintColor: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.houseChimney,
                isSelected: _selectedIndex == 0,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(0),
              ),
              NavTab(
                text: "Discover",
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    _isTapDown = true;
                  });
                },
                onTapUp: (details) => _onPostVideoTap(),
                child: PostVideoButton(
                  isTapDown: _isTapDown,
                  inverted: _selectedIndex != 0,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                icon: FontAwesomeIcons.inbox,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(3),
              ),
              NavTab(
                text: "Profile",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                selectedIndex: _selectedIndex,
                onTap: () => _onNavTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
