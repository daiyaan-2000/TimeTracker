import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:time_tracker/widgets/task_descriptions.dart';
import 'dart:math' as math;

class TimerDetailPage extends StatelessWidget {
  final String title;
  final String timer;
  final List details;
  final Color randomColor = Color(
    (math.Random().nextDouble() * 0xFFFFFF).toInt(),
  );

  TimerDetailPage({
    super.key,
    required this.title,
    required this.timer,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    List<String> parts = timer.split(":"); // ["32", "15"]
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);

    double num = (seconds / 60);
    double percentage = (minutes + num) / 100;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          Row(
            spacing: 6,
            children: [
              if (details.isNotEmpty)
                TaskDescriptions(
                  label: details.first,
                  color: Colors.deepPurpleAccent,
                ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fiber_manual_record_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            //SizedBox(height: 80),
            CircularPercentIndicator(
              linearGradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 179, 155, 246),
                  Colors.deepPurpleAccent,
                  const Color.fromARGB(255, 86, 29, 241),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              radius: 110,
              //progressColor: Colors.deepPurpleAccent,
              backgroundColor: const Color.fromARGB(255, 225, 224, 224),
              percent: percentage,
              lineWidth: 20,
              animation: true,
              center: Text(
                timer,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ),

            //SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(233, 233, 255, 100),
                      radius: 32,
                      child: Icon(
                        Icons.play_arrow,
                        size: 32,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Resume',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromRGBO(233, 233, 255, 100),
                      radius: 32,
                      child: Icon(Icons.stop, size: 32, color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
