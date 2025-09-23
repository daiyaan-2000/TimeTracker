import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home.dart';
import 'package:time_tracker/pages/productivity.dart';
import 'package:time_tracker/pages/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> tabs = [
    HomePage(),
    ProductivityPage(),
    SizedBox(),
    ProfilePage(),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,

        currentIndex: selectedIndex,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color.fromARGB(255, 27, 87, 110),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Productivity',
            backgroundColor: Color.fromARGB(255, 95, 159, 184),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add New',
            backgroundColor: Color.fromARGB(255, 27, 87, 110),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Profile',
            backgroundColor: Color.fromARGB(255, 95, 159, 184),
          ),
        ],
      ),
    );
  }
}
