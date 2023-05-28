import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/my_home_page.dart';
import 'package:flutter_application_1/home/toJson.dart';

class NavigationRailPage2 extends StatefulWidget {
  const NavigationRailPage2({Key? key}) : super(key: key);

  @override
  State<NavigationRailPage2> createState() => _NavigationRailPage2State();
}

const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.bookmark_border_outlined),
    activeIcon: Icon(Icons.bookmark_rounded),
    label: 'Bookmarks',
  ),
];

class _NavigationRailPage2State extends State<NavigationRailPage2> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/first',
      routes: {
        '/first': (context) => MyHomePage(title: 'Home page'),
        '/second': (context) => Convert2Json(),
      },
    );
  }
}
