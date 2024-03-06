import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingPage extends StatelessWidget {
  static const routeName = 'landingPage';
  static const routePath = '/landingPage';

  final StatefulNavigationShell navigationShell;
  const LandingPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        backgroundColor: Colors.amber,
        elevation: 10,
        enableFeedback: true,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedIconTheme: const IconThemeData(color: Colors.black45),
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Music',
          ),
        ],
      ),
    );
  }
}
