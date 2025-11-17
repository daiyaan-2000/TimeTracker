//lib/features/tasks/data/datasources/hive_task_datasource.dart

import 'package:hive_ce/hive.dart';
import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';

class HiveTaskDataSource {
  HiveTaskDataSource(this.box);

  final Box box;
  static const String _boxKey = 'tasks';

  //reading from hive
  Future<List<Task>> loadTasks() async {
    //We ask Hive: “hey, give me whatever you have saved under the name 'tasks'.”
    final dynamic raw = box.get(_boxKey);

    if (raw == null) {
      return <Task>[];
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

  Future<void> saveTasks(List<Task> tasks) async {
    final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (final t in tasks) {
      list.add(t.toMap());
    }
    await box.put(_boxKey, list);
  }
}
