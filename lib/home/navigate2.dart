import 'package:flutter/material.dart';
import 'package:flutter_application_1/home/my_home_page.dart';
import 'package:flutter_application_1/home/toJson.dart';

class NavigationRailPage2 extends StatefulWidget {
  const NavigationRailPage2({Key? key}) : super(key: key);

  @override
  State<NavigationRailPage2> createState() => _NavigationRailPage2State();
}

class _NavigationRailPage2State extends State<NavigationRailPage2> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/first',
      routes: {
        '/first': (context) => const MyHomePage(title: 'Home page'),
        '/second': (context) => const Convert2Json(),
      },
    );
  }
}
