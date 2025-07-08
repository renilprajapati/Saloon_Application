import 'package:flutter/material.dart';
import 'package:saloon_app/Common/Profile/Views/my_profile.dart';
import 'package:saloon_app/Common/common_colors.dart';
import 'package:saloon_app/BottomBar/Home/Screen/HomePage.dart';

import '../BookingHistory/Screen/BookingHistoryScreen.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    BookingHistoryScreen(
      route: 'BottomBarScreen',
    ),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        currentIndex: _currentIndex,
        fixedColor: common_clr,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: common_clr,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_edu_outlined,
              color: common_clr,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: common_clr,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
