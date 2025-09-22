import 'package:flutter/material.dart';

class stopwatchPage extends StatelessWidget {
  const stopwatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Color.fromARGB(255, 38, 88, 108),
      body: Center(
        child: CircleAvatar(
          radius: 200,
          backgroundColor: Color.fromARGB(255, 226, 246, 253),
          child: CircleAvatar(
            radius: 180,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
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
        'Stopwatch Page',
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
