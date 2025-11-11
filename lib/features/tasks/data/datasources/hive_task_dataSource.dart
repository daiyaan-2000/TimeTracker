// lib/features/tasks/data/datasources/hive_task_dataSource.dart

import 'package:hive_ce/hive.dart';
import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';

class HiveTaskDataSource {
  HiveTaskDataSource(this.box);

  final Box box;

  static const String _boxKey = 'tasks';

  // read from hive
  Future<List<Task>> loadTasks() async {
    final dynamic raw = box.get(_boxKey);

    if (raw == null) {
      return <Task>[]; // empty, we'll let upper layers decide to seed
    }

    final List<Task> loaded = <Task>[];

    if (raw is List) {
      for (final item in raw) {
        if (item is Map) {
          final map = Map<String, dynamic>.from(item as Map);
          loaded.add(Task.fromMap(map));
        }
      }
    }

    return loaded;
  }

  // write to hive
  Future<void> saveTasks(List<Task> tasks) async {
    final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (final t in tasks) {
      list.add(t.toMap());
    }
    await box.put(_boxKey, list);
  }
}
