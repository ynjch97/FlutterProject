import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = const [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Home"))
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onNavTap,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting, // 전환 효과
        selectedItemColor: Theme.of(context).primaryColor,
        // _AssertionError (Failed assertion: 'items.length >= 2' : is not true.) => item 하위에 2개 이상의 item 이 존재해야 함
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "Search",
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "Home",
            backgroundColor: Colors.amberAccent,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Search",
            tooltip: "Search",
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "Home",
            backgroundColor: Colors.amberAccent,
          ),
        ],
      ),
    );
  }
}
