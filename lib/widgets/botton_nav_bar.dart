import 'package:flutter/material.dart';
import 'package:time_tracker/pages/add_new_page.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
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
    AddNew(),
    ReportPage(),
    //ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          elevation: 0,
          selectedItemColor: Colors.black,
          selectedFontSize: 0,
          type: BottomNavigationBarType.fixed,

          currentIndex: selectedIndex,

          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },

          items: [
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: selectedIndex == 0
                    ? Colors.black
                    : Colors.transparent,
                child: Icon(
                  Icons.home,
                  size: 30,
                  color: selectedIndex == 0 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Home',
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: selectedIndex == 1
                    ? Colors.black
                    : Colors.transparent,
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: selectedIndex == 1 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Add New',
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: selectedIndex == 2
                    ? Colors.black
                    : Colors.transparent,
                child: Icon(
                  Icons.pie_chart,
                  size: 30,
                  color: selectedIndex == 2 ? Colors.white : Colors.grey,
                ),
              ),
              label: 'Add New',
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            /*
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2),
              label: 'Profile',
              backgroundColor: Color.fromARGB(255, 79, 138, 162),
            ),
            */
          ],
        ),
      ),
    );
  }
}
