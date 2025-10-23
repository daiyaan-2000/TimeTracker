import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/current_timer.dart';
import 'package:time_tracker/widgets/task_cards.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/task_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        // in ReportPage AppBar actions:
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Reset all timers',
            onPressed: () {
              // calls the method we just added
              ref.read(tasksProvider.notifier).resetAllTimers();
            },
          ),
        ],
      ),
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
            CurrentTimer(),
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
