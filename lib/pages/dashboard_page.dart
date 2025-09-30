import 'package:flutter/material.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
//import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:math' as math;

import 'package:time_tracker/widgets/current_timer.dart';
import 'package:time_tracker/widgets/task_cards.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      /*
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 224, 213, 252),
        child: Column(
          children: [
            AppBar(
              title: Center(child: Text('App drawer')),
              leading: Text(''),
            ),
            Text('data'),
            Text('data'),
          ],
        ),
      ),
      */
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                ImageIcon(
                  AssetImage('assets/icons/more.png'),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  'See All',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TaskCards(
              iconInfo: 'assets/icons/monitor.png',
              title: 'Flutter Project',
              timer: '45:15',
              details: ['Work', 'UI Design'],
            ),
            TaskCards(
              iconInfo: Icons.language,
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
              iconInfo: Icons.sports_soccer,
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
