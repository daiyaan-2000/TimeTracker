import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class TimerDetailPage extends StatelessWidget {
  final String title;
  final String timer;

  const TimerDetailPage({super.key, required this.title, required this.timer});

  @override
  Widget build(BuildContext context) {
    List<String> parts = timer.split(":"); // ["32", "15"]
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);

    double num = (seconds / 60);
    double percentage = (minutes + num) / 100;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fiber_manual_record_outlined),
                SizedBox(width: 12),
                Text('UI Design', style: TextStyle(fontSize: 16)),
              ],
            ),
            //SizedBox(height: 80),
            CircularPercentIndicator(
              radius: 110,
              progressColor: Colors.deepPurpleAccent,
              backgroundColor: const Color.fromARGB(255, 225, 224, 224),
              percent: percentage,
              lineWidth: 20,
              animation: true,
              center: Text(
                timer,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                        fontWeight: FontWeight.normal,
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
                        fontWeight: FontWeight.normal,
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
