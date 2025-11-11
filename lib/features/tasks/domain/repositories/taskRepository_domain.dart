// lib/features/tasks/domain/repositories/taskRepository_domain.dart

import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';

abstract class TaskRepository {
  //getting everything thats saved manually
  Future<List<Task>> getAllTasks();

  //saving updates
  Future<void> saveTasks(List<Task> tasks);
}
