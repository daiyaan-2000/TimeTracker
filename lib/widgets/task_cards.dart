import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/widgets/task_labels.dart';
import 'package:time_tracker/providers/tasks.dart';

class TaskCards extends ConsumerWidget {
  TaskCards({super.key, required this.taskId});

  final String taskId;

  Color colorFromId(String id) {
    final int hash = id.hashCode & 0x00FFFFFF;
    return Color(0xFF000000 | hash);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final String iconFile = 'assets/icons/$iconInfo';
    final Task? task = ref.watch(
      tasksProvider.select((list) {
        try {
          return list.firstWhere((t) => t.id == taskId);
        } catch (_) {
          return null;
        }
      }),
    );

    if (task == null) {
      return const SizedBox(height: 80);
    }

    final Color stableColor = colorFromId(task.id);

    final timerText = task.timerText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        //borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => TimerDetailPage(taskId: taskId)),
          );
        },

        child: Container(
          //1
          margin: EdgeInsets.only(bottom: 16),
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            /*boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
              ),
            ],*/
          ),
          child: Row(
            //2
            //spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  //3
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: stableColor,
                      radius: 22,
                      child: task.iconInfo.runtimeType == IconData
                          ? Icon(task.iconInfo, color: Colors.white)
                          : ImageIcon(
                              AssetImage(task.iconInfo),
                              color: Colors.white,
                            ),
                    ),

                    Expanded(
                      child: Column(
                        //4
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            task.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),

                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (var i in task.details)
                                TaskLabels(label: i, color: stableColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: Column(
                  //6
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TimerText(taskId: taskId),
                    SizedBox(height: 8),
                    PlayPauseButton(taskId: taskId),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerText extends ConsumerWidget {
  const TimerText({super.key, required this.taskId});
  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String timerText = ref.watch(
      tasksProvider.select((tasks) {
        try {
          final task = tasks.firstWhere((t) => t.id == taskId);
          return task.timerText;
        } catch (_) {
          return '--:--';
        }
      }),
    );

    return Text(
      timerText,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    );
  }
}

class PlayPauseButton extends ConsumerWidget {
  const PlayPauseButton({super.key, required this.taskId});
  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TimerMode mode = ref.watch(
      tasksProvider.select((tasks) {
        try {
          final task = tasks.firstWhere((t) => t.id == taskId);
          return task.mode;
        } catch (_) {
          return TimerMode.paused;
        }
      }),
    );

    final TasksController controller = ref.read(tasksProvider.notifier);

    IconData icon;

    VoidCallback onPressed;

    if (mode == TimerMode.running) {
      icon = Icons.pause;

      onPressed = () {
        controller.pause(taskId);
      };
    } else if (mode == TimerMode.paused) {
      icon = Icons.play_arrow;

      onPressed = () {
        controller.start(taskId);
      };
    } else {
      // stopped
      icon = Icons.play_arrow;

      onPressed = () {
        controller.start(taskId);
      };
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(32, 32),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: const Size(5, 5),
      ),
      child: Icon(icon, size: 32, color: Colors.grey),
    );
  }
}
