import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/app_provider.dart';
import '../main_pages/home_page.dart';
import 'main_bottom_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/MainScreen';

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    Text('BetScreen()'),
    Text('AddPage()'),
    Text('MessagePage()'),
    Text('MyProdilePage()'),
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentTap;
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: const MainBottomNavigationBar(),
    );
  }
}
