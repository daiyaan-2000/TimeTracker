import 'package:flutter/material.dart';
import 'package:time_tracker/pages/add_new_page.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
import 'package:time_tracker/pages/report_page.dart';
import 'package:time_tracker/pages/profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/bottomNavState_provider.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends ConsumerState<BottomNavBar> {
  List<Map<String, dynamic>> currentTaskCards = [
    {
      'iconInfo': 'assets/icons/monitor.png',
      'title': 'Flutter Project',
      'timer': '45:15',
      'details': ['Work', 'UI Design'],
      'minutes': 60,
    },
    {
      'iconInfo': Icons.language,
      'title': 'Dart Language Training',
      'timer': '60:00',
      'details': ['Loops', 'Conditionals', 'Widgets'],
      'minutes': 60,
    },
    {
      'iconInfo': Icons.sports_soccer,
      'title': 'Footy Practice',
      'timer': '20:05',
      'details': ['Drills', 'Matches'],
      'minutes': 60,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedTabProvider);
    final List<Widget> tabs = [
      DashboardPage(),
      AddNew(),
      ReportPage(),
      //ProfilePage(),
    ];

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
              ref.read(selectedTabProvider.notifier).state = index;
            });
          },

          items: [
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: selectedIndex == 0
                    ? ImageIcon(
                        AssetImage('assets/icons/Icon Time.png'),
                        size: 30,
                        //color: Colors.white,
                      )
                    : ImageIcon(
                        AssetImage('assets/icons/time-outline.png'),
                        size: 30,
                        color: Colors.grey,
                      ),
              ),
              label: 'Home',
              //backgroundColor: Color.fromARGB(255, 0, 0, 0),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 22,
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
                backgroundColor: Colors.transparent,
                child: selectedIndex == 2
                    ? ImageIcon(
                        AssetImage('assets/icons/pie-chart filled.png'),
                        size: 30,
                        //color: Colors.white,
                      )
                    : ImageIcon(
                        AssetImage('assets/icons/pie-chart.png'),
                        size: 30,
                        color: Colors.grey,
                      ),
              ),
              label: 'Home',
              //backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
