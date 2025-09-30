import 'package:flutter/material.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:math' as math;

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: myappBar('TIME TRACKER APP'),
      backgroundColor: Color.fromRGBO(250, 250, 255, 100),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ImageIcon(
                  AssetImage('assets/icons/analytics.png'),
                  color: Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 24),
            CurrentTimer(timer: '50:45', title: 'TimePad Project'),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TaskCards(
              iconData: Icons.computer,
              title: 'Flutter Project',
              timer: '45:15',
              details: ['Work', 'UI Design'],
            ),
            TaskCards(
              iconData: Icons.language,
              title: 'Dart Language Training',
              timer: '60:00',
              details: [
                'Loops',
                'Conditionals',
                'Widgets',
                'Asynchronous programming',
              ],
            ),
            TaskCards(
              iconData: Icons.sports_soccer,
              title: 'Footy Practice',
              timer: '20:05',
              details: ['Drills', 'Matches', 'Warmup'],
            ),
          ],
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
        //margin: EdgeInsets.only(bottom: 16),
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          /*boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
              offset: Offset(0, 4),
            ),
          ]*/
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  timer,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 25),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Icon(
                  Icons.fiber_manual_record_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                SizedBox(width: 12),
                Text(title, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCards extends StatelessWidget {
  TaskCards({
    super.key,
    required this.iconData,
    required this.title,
    required this.timer,
    this.details = const [],
  });

  final IconData iconData;
  final String title;
  final String timer;
  final List<String> details;
  final Color randomColor = Color(
    (math.Random().nextDouble() * 0xFFFFFF).toInt(),
  );

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
            borderRadius: BorderRadius.circular(12),
            /*boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
              ),
            ],*/
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
                      backgroundColor: randomColor.withOpacity(1.0),
                      radius: 25,
                      child: Icon(iconData, color: Colors.white),
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
                              fontSize: 14,
                            ),
                          ),

                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (var i in details)
                                TaskDescriptions(label: i, color: randomColor),
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
                    Text(timer, style: TextStyle(fontSize: 12)),
                    SizedBox(height: 8),
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 32,
                      color: Colors.grey,
                    ),
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

class TaskDescriptions extends StatelessWidget {
  TaskDescriptions({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: color.withOpacity(1), fontSize: 12),
      ),
    );
  }
}
