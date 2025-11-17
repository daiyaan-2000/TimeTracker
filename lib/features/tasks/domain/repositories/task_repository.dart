//lib/features/tasks/domain/repositories/task_repository.dart
import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';

/// This is the contract for "something that can give me tasks
/// and let me save tasks".
abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<void> saveTasks(List<Task> tasks);
}
