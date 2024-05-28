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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onNavTap,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.grey.shade400,
        destinations: [
          NavigationDestination(
            icon: const FaIcon(
              FontAwesomeIcons.house,
              color: Colors.white,
            ),
            selectedIcon: FaIcon(
              FontAwesomeIcons.house,
              color: Theme.of(context).primaryColor,
            ),
            label: "Home",
            tooltip: "Home",
          ),
          NavigationDestination(
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.white,
            ),
            selectedIcon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Theme.of(context).primaryColor,
            ),
            label: "Search",
            tooltip: "Search",
          ),
        ],
      ),
    );
  }
}
