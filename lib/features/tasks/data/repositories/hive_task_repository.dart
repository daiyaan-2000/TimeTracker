// lib/features/tasks/data/repositories/hive_task_repository.dart
import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';
import 'package:time_tracker/features/tasks/data/datasources/hive_task_datasource.dart';

/// Data-layer implementation of the domain repository.
/// It knows *how* to fetch/save (via Hive), but only exposes the
/// domain-friendly methods defined in TaskRepository.
class HiveTaskRepository implements TaskRepository {
  HiveTaskRepository(this._dataSource);

  final HiveTaskDataSource _dataSource;

  @override
  Future<List<Task>> getAllTasks() {
    // Just ask the data source for tasks.
    // If there are none, it'll return an empty list (we can decide
    // where to seed later—keeping it simple for now).
    return _dataSource.loadTasks();
  }

  @override
  Future<void> saveTasks(List<Task> tasks) {
    // Forward the save request to the data source.
    return _dataSource.saveTasks(tasks);
  }
}
