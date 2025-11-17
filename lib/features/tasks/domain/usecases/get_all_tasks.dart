import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';

class GetAllTasksUseCase {
  final TaskRepository repo;

  GetAllTasksUseCase(this.repo);

  Future<List<Task>> call() {
    return repo.getAllTasks();
  }
}
