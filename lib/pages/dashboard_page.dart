import 'package:flutter/material.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
//import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:math' as math;
import 'package:time_tracker/widgets/current_timer.dart';
import 'package:time_tracker/widgets/task_cards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/task_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  //final List<Map<String, dynamic>> tasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(tasksProvider);
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
            CurrentTimer(taskId: 't1'),
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

            Column(
              children: taskList.map((task) {
                return TaskCards(taskId: task.id);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
