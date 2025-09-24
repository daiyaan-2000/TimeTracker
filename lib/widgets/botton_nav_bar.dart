import 'package:flutter/material.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
import 'package:time_tracker/pages/opening_page.dart';
import 'package:time_tracker/pages/report_page.dart';
import 'package:time_tracker/pages/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> tabs = [
    DashboardPage(),
    ReportPage(),
    OpeningPage(),
    ProfilePage(),
  ];

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
