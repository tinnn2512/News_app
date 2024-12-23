import 'package:flutter/material.dart';
import 'package:news_app/views/home_page/homepage.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../category_screen/category_screen.dart';

class CustomBar extends StatefulWidget {
  const CustomBar({super.key});

  @override
  State<CustomBar> createState() => _CustomBarState();
}

class _CustomBarState extends State<CustomBar> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _navScreens() {
    return [
      const HomePage(),
      const CategoryScreen(),
      // const VideoScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.blue,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.category),
        title: 'Category',
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: Colors.blue,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.videocam),
      //   inactiveColorPrimary: Colors.grey,
      //   activeColorPrimary: Colors.black,
      //   title: 'Video',
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _navScreens(),
      items: _navBarsItems(),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
