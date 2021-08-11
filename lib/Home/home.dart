import 'package:fin_tech_app/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'Categories/categories.dart';
import 'Chat/chat.dart';
import 'Profile/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Categories(),
    Profile(),
    Chat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: cardColor,
        selectedItemColor: mainColor,
        unselectedItemColor: kWhite,
        selectedIconTheme: IconThemeData(size: 30.0),
        unselectedIconTheme: IconThemeData(size: 30.0),
        selectedFontSize: 12.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            activeIcon: Icon(Icons.add),
            label: 'ADD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_outlined),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(
              Icons.chat_outlined,
            ),
            label: 'BOT',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
