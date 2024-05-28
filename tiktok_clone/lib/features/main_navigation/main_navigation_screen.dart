import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/stf_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';

import 'widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
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
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const StfScreen(
              text: "Home",
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const StfScreen(
              text: "Discover",
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const StfScreen(
              text: "Inbox",
            ),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const StfScreen(
              text: "Profile",
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
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
                onTap: () => _onNavTap(0),
              ),
              NavTab(
                text: "Discover",
                icon: FontAwesomeIcons.magnifyingGlass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
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
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                icon: FontAwesomeIcons.inbox,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                onTap: () => _onNavTap(3),
              ),
              NavTab(
                text: "Profile",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                onTap: () => _onNavTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
