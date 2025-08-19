import 'package:flutter/material.dart';
import 'package:project_1/features/home/pages/homepage.dart';
import 'package:project_1/features/home/pages/setting_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  PageController pageController = PageController();
  int index = 0;

  final List<BottomNavigationBarItem> bottomNavItemList = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: '',
    ),
  ];

  final List<Widget> pages = [
    HomePage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: (value) {
          setState(() {
            index = value;
          });
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashFactory: NoSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          items: bottomNavItemList,
          elevation: 2,
          currentIndex: index,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (value) {
            setState(() {
              index = value;
              pageController.jumpToPage(value);
            });
          },
        ),
      ),
    );
  }
}
