import 'package:flutter/material.dart';
import 'package:time_tracker/pages/report_page.dart';
import 'package:time_tracker/pages/stopwatch.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/widgets/botton_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CurrentTimer(timer: '00:32:45', title: 'TimePad Project'),
            SizedBox(height: 16),
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
              timer: '08:45:15',
              details: ['Work', 'UI Design'],
            ),
            TimerCard(
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Dart Language Training',
              timer: '00:00:00',
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
              timer: '00:00:00',
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

class CurrentTimer extends StatelessWidget {
  const CurrentTimer({super.key, required this.timer, required this.title});

  final String timer;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TimerDetailPage(title: title, timer: timer),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 231, 246, 251),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timer,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 25),
              ],
            ),
            Text(title, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

class TimerCard extends StatelessWidget {
  const TimerCard({
    super.key,
    required this.icon,
    required this.title,
    required this.timer,
    this.details = const [],
  });

  final Icon icon;
  final String title;
  final String timer;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TimerDetailPage(title: title, timer: timer),
            ),
          );
        },

        child: Container(
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
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(0, 2),
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
                    Text(timer),
                    Icon(Icons.play_arrow_rounded, size: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
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
        color: Color.fromARGB(255, 79, 138, 162),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: Colors.white)),
    );
  }
}
