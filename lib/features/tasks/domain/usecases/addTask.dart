// lib/features/tasks/domain/usecases/addTask.dart

import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  AddTaskUseCase(this._repo);

  final TaskRepository _repo;

  /// This use case:
  /// - takes the current list of tasks from the provider
  /// - builds a new Task
  /// - returns the updated list after saving via the repository
  Future<List<Task>> call({
    required List<Task> currentTasks,
    required String title,
    required List<String> details,
    required int totalMinutes,
    dynamic iconInfo,
  }) async {
    // 1) Build the new Task (business rule)
    final newTask = Task(
      id: 't${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      details: details,
      iconInfo: iconInfo ?? 'assets/icons/monitor.png',
      totalMinutes: totalMinutes,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    );

    // 2) Decide how to insert in the list (here: new one on top)
    final updatedTasks = <Task>[newTask, ...currentTasks];

    // 3) Persist using the repository (domain-facing)
    await _repo.saveTasks(updatedTasks);

    // 4) Return updated list so the provider can update its state
    return updatedTasks;
  }
}
