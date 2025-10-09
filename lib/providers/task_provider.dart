import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tasks.dart';

class TasksController extends StateNotifier<List<Task>> {
  TasksController() : super(_seedTasks());

  static List<Task> _seedTasks() => [
    Task(
      id: 't1',
      title: 'Riverpod Project',
      details: ['Work', 'UI Design'],
      iconInfo: 'assets/icons/monitor.png',
      totalMinutes: 60,
      timerText: '45:15',
    ),
    Task(
      id: 't2',
      title: 'Dart Language Training',
      details: ['Loops', 'Conditionals', 'Widgets'],
      iconInfo: Icons.language,
      totalMinutes: 60,
      timerText: '60:00',
    ),
    Task(
      id: 't3',
      title: 'Footy Practice',
      details: ['Drills', 'Matches'],
      iconInfo: Icons.sports_soccer,
      totalMinutes: 60,
      timerText: '20:05',
    ),
  ];
  //ADDDDD
  void addTask({
    required String title,
    required List<String> details,
    required int totalMinutes,
    dynamic iconInfo,
  }) {
    final newTask = Task(
      id: 't${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      details: details,
      iconInfo: iconInfo ?? 'assets/icons/monitor.png',
      totalMinutes: totalMinutes,
      timerText: '00:00',
    );
    state = [newTask, ...state];
  }
}

final tasksProvider = StateNotifierProvider<TasksController, List<Task>>((ref) {
  return TasksController();
});
