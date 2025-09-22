import 'package:flutter/material.dart';
import 'package:time_tracker/pages/stopwatch.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(context),
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
            ),
            TimerCard(
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Dart Language Trainingg Trainingg Trainingg',
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

  //------------------------------------------------------------------

  BottomAppBar bottomBar(BuildContext context) {
    return BottomAppBar(
      color: Color.fromARGB(255, 255, 255, 255),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => stopwatchPage()));
            },

            //padding: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Color.fromARGB(255, 27, 87, 110),
              child: Icon(Icons.add, size: 40, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------------------------------------------------------------------------

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

class TimerCard extends StatelessWidget {
  const TimerCard({super.key, required this.icon, required this.title});

  final Icon icon;
  final String title;

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

                      Row(
                        //5
                        children: [
                          TaskContainers(label: 'Work'),
                          SizedBox(width: 5),
                          TaskContainers(label: 'Flutter Project'),
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
      alignment: Alignment.center,
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
