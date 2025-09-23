import 'package:flutter/material.dart';
import 'package:time_tracker/pages/productivity.dart';
import 'package:time_tracker/pages/stopwatch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            TimerCard(
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Flutter Project',
              details: ['Work', 'UI Design'],
            ),
            TimerCard(
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Dart Language Training',
              details: [
                'Loops',
                'Conditionals',
                'Widgets',
                'Asynchronous programming',
              ],
            ),
            TimerCard(
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Footy Practice',
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      centerTitle: true,
      elevation: 0,
      leading: Icon(Icons.home),
      actions: [
        Icon(Icons.notification_add),
        SizedBox(width: 20),
        Icon(Icons.person),
        SizedBox(width: 20),
        Icon(Icons.settings),
        SizedBox(width: 20),
      ],
      title: Text(
        'TIME TRACKER APP',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          wordSpacing: 8,
        ),
      ),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<BottomNav> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,

      currentIndex: selectedIndex,

      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });

        if (index == 1) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => ProductivityPage()));
        } else if (index == 0) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => HomePage()));
        }
        ;
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
    );
  }
}

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.icon,
    required this.title,
    this.details = const [],
  });

  final Icon icon;
  final String title;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Container(
      //1
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        //2
        //spacing: 16,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              //3
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 27, 87, 110),
                  radius: 25,
                  child: icon,
                ),

                Expanded(
                  child: Column(
                    //4
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),

                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: [
                          for (var i in details) TaskContainers(label: i),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Flexible(
            child: Column(
              //6
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('00:00:00'),
                Icon(Icons.play_arrow_rounded, size: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskContainers extends StatelessWidget {
  const TaskContainers({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 95, 159, 184),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(color: Color.fromARGB(255, 38, 88, 108)),
      ),
    );
  }
}
