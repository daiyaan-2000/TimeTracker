import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';

class StartTaskUseCase {
  final TaskRepository repo;

  StartTaskUseCase(this.repo);

  Future<List<Task>> call({
    required List<Task> currentTasks,
    required String taskId,
  }) async {
    //Building a new list of tasks
    final List<Task> updatedTasks = currentTasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(mode: TimerMode.running);
      } else {
        //Stopping all others
        return task.copyWith(mode: TimerMode.stopped);
      }
    }).toList();

    await repo.saveTasks(updatedTasks);

    return updatedTasks;
  }
}
