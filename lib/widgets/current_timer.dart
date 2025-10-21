import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/providers/tasks.dart';

class CurrentTimer extends ConsumerWidget {
  const CurrentTimer({super.key});

  //final String timer;
  //final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    if (tasks.isEmpty) {
      // Hive is still loading. Show a small placeholder.
      return const SizedBox(
        height: 80,
        child: Center(child: Text('Loading...')),
      );
    }

    final runningTask = tasks.where((t) => t.mode == TimerMode.running);

    /*
    final task = tasks.firstWhere(
      (t) => t.id == taskId,
      orElse: () => throw Exception('Task not found: $taskId'),
    );
    */

    late final Task task;
    if (runningTask.isNotEmpty) {
      task = runningTask.first;
    } else {
      task = tasks.first;
    }

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => TimerDetailPage(taskId: task.id)),
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
                  task.timerText,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Rubik',
                  ),
                ),
                ImageIcon(AssetImage('assets/icons/right arrow.png'), size: 25),
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
                Text(
                  task.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
