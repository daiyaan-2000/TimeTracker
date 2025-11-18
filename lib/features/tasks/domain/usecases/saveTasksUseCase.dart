import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';

class SaveTasksUseCase {
  final TaskRepository repo;

  SaveTasksUseCase(this.repo);

  Future<void> call(List<Task> tasks) {
    return repo.saveTasks(tasks);
  }
}
