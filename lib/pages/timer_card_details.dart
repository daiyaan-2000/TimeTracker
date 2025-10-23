import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/widgets/task_labels.dart';
import 'dart:math' as math;

class TimerDetailPage extends ConsumerWidget {
  const TimerDetailPage({super.key, required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1) watch the whole task list
    final tasks = ref.watch(tasksProvider);

    // 2) find this task by id
    final task = tasks.firstWhere(
      (t) => t.id == taskId,
      orElse: () => throw Exception('Task not found: $taskId'),
    );

    // 3) for actions (start/pause/...) we read the notifier
    final controller = ref.read(tasksProvider.notifier);

    // 4) convenience values from the model
    final percent = task.percentOfGoal; // 0.0..1.0
    final timerText = task.timerText; // "MM:SS"
    final details = task.details;

    final randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            task.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          Row(
            spacing: 6,
            children: [
              if (details.isNotEmpty)
                TaskLabels(
                  label: details.first,
                  color: Colors.deepPurpleAccent,
                ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // title row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.fiber_manual_record_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                const SizedBox(width: 12),
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            //CIRCULAR PERCENT INDICATOR
            CircularPercentIndicator(
              linearGradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 179, 155, 246),
                  Colors.deepPurpleAccent,
                  Color.fromARGB(255, 86, 29, 241),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              radius: 110,
              backgroundColor: const Color.fromARGB(255, 225, 224, 224),
              percent: percent,
              lineWidth: 20,
              center: Text(
                timerText,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            //BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //START
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.start(taskId),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(32, 32),
                        shape: const CircleBorder(),
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color.fromRGBO(
                          233,
                          233,
                          255,
                          100,
                        ),
                        radius: 32,
                        child: const Icon(
                          Icons.play_arrow,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                //STOP
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.stop(taskId, reset: false),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(32, 32),
                        shape: const CircleBorder(),
                      ),
                      child: CircleAvatar(
                        backgroundColor: const Color.fromRGBO(
                          233,
                          233,
                          255,
                          100,
                        ),
                        radius: 32,
                        child: const Icon(
                          Icons.stop,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
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
