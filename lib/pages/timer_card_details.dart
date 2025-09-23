import 'package:flutter/material.dart';

class TimerDetailPage extends StatelessWidget {
  final String title;
  final String timer;

  const TimerDetailPage({super.key, required this.title, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      backgroundColor: const Color.fromARGB(255, 27, 87, 110),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 400,
              padding: EdgeInsets.all(30),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 95, 159, 184),
                  width: 10,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.transparent.withOpacity(0.2),
                    spreadRadius: 20,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                timer,
                style: const TextStyle(color: Colors.white, fontSize: 64),
              ),
            ),
            SizedBox(height: 64),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 95, 159, 184),
                      radius: 32,
                      child: Icon(Icons.play_arrow, size: 32),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 95, 159, 184),
                      radius: 32,
                      child: Icon(Icons.stop, size: 32),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: 16,
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
