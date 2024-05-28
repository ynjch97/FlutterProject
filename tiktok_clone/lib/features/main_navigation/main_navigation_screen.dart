import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

import 'widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = const [
    Center(child: Text("Home")),
    Center(child: Text("Discover")),
    Center(child: Text("+")),
    Center(child: Text("Inbox")),
    Center(child: Text("Profile"))
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainNavigationScreen"),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                text: "Home",
                isSelected: _selectedIndex == 0,
                onTap: () => _onNavTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.magnifyingGlass,
                text: "Discover",
                isSelected: _selectedIndex == 1,
                onTap: () => _onNavTap(1),
              ),
              NavTab(
                icon: FontAwesomeIcons.inbox,
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                onTap: () => _onNavTap(3),
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                text: "Profile",
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
