import 'package:flutter/material.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/widgets/app_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('TIME TRACKER APP'),
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            SizedBox(height: 24),
            CurrentTimer(timer: '00:32:45', title: 'TimePad Project'),
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
              icon: Icon(Icons.computer, color: Colors.white),
              title: 'Flutter Project',
              timer: '08:45:15',
              details: ['Work', 'UI Design'],
            ),
            TaskCards(
              icon: Icon(Icons.language, color: Colors.white),
              title: 'Dart Language Training',
              timer: '00:00:00',
              details: [
                'Loops',
                'Conditionals',
                'Widgets',
                'Asynchronous programming',
              ],
            ),
            TaskCards(
              icon: Icon(Icons.sports_soccer, color: Colors.white),
              title: 'Footy Practice',
              timer: '00:00:00',
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
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.arrow_forward_ios, size: 25),
              ],
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.fiber_manual_record_outlined),
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
  const TaskCards({
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
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
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
                              fontSize: 14,
                            ),
                          ),

                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (var i in details) TaskDescriptions(label: i),
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
  const TaskDescriptions({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 79, 138, 162),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
