import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';

/// Domain logic for "stopping" a task.
/// It knows:
///  - which task to stop
///  - whether to reset its elapsed time
///  - and it saves the result via the repository.
class StopTaskUseCase {
  final TaskRepository repo;

  StopTaskUseCase(this.repo);

  Future<List<Task>> call({
    required List<Task> currentTasks,
    required String taskId,
    required bool reset,
  }) async {
    // Build a new list of tasks with updated mode/elapsed for the target task
    final List<Task> updatedTasks = currentTasks.map((task) {
      if (task.id != taskId) {
        // All other tasks stay exactly the same
        return task;
      }

      // Domain rule: when we stop a task,
      // we might or might not reset its elapsed time.
      final int newElapsedSeconds = reset ? 0 : task.elapsedSeconds;

      return task.copyWith(
        mode: TimerMode.stopped,
        elapsedSeconds: newElapsedSeconds,
      );
    }).toList();

    // Save to storage (Hive under the hood, but domain doesn't care)
    await repo.saveTasks(updatedTasks);

    return updatedTasks;
  }
}
