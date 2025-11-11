// lib/features/tasks/domain/repositories/taskRepository_data.dart

import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/taskRepository_domain.dart';
import 'package:time_tracker/features/tasks/data/datasources/hive_task_datasource.dart';

class TaskRepositoryBase implements TaskRepository {
  TaskRepositoryBase(this.dataSource);

  final HiveTaskDataSource dataSource;

  @override
  Future<List<Task>> getAllTasks() async {
    final tasks = await dataSource.loadTasks();

    //
    if (tasks.isEmpty) {
      return _seedTasks();
    }
    return tasks;
  }

  @override
  Future<void> saveTasks(List<Task> tasks) {
    return dataSource.saveTasks(tasks);
  }

  //taking from task controller
  List<Task> _seedTasks() {
    return [
      Task(
        id: 't1',
        title: 'Riverpod Project',
        details: ['Work', 'UI Design'],
        iconInfo: 'assets/icons/monitor.png',
        totalMinutes: 60,
        elapsedSeconds: 0,
        mode: TimerMode.stopped,
      ),
      Task(
        id: 't2',
        title: 'Dart Language Training',
        details: ['Loops', 'Conditionals', 'Widgets'],
        iconInfo: 'assets/icons/monitor.png',
        totalMinutes: 60,
        elapsedSeconds: 0,
        mode: TimerMode.stopped,
      ),
      Task(
        id: 't3',
        title: 'Footy Practice',
        details: ['Drills', 'Matches'],
        iconInfo: 'assets/icons/monitor.png',
        totalMinutes: 60,
        elapsedSeconds: 0,
        mode: TimerMode.stopped,
      ),
    ];
  }
}
