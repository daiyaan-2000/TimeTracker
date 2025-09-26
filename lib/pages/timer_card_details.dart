import 'package:flutter/material.dart';

class TimerDetailPage extends StatelessWidget {
  final String title;
  final String timer;

  const TimerDetailPage({super.key, required this.title, required this.timer});

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 250,
              width: 250,
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 10,
                  color: const Color.fromARGB(255, 145, 94, 234),
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                timer,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
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
