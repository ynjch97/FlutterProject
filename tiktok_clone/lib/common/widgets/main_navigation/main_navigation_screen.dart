import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

import '../../../features/users/user_profile_screen.dart';
import 'widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  static const routeURL = Routes.mainScreen;
  static const routeName = RoutesName.mainScreen;

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex = Tabs.mainTabs.indexOf(widget.tab);
  bool _isTapDown = false;

  void _onNavTap(int index) {
    context.go("/${Tabs.mainTabs[index]}"); // URL 도 이동

    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoTap() {
    context.pushNamed(VideoRecordingScreen.routeName);

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
