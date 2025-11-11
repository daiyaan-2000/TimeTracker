import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';

import 'package:time_tracker/providers/hiveBoxProvider.dart';
import 'package:time_tracker/providers/graphStatsProvider.dart';

import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/data/datasources/hive_task_datasource.dart';
import 'package:time_tracker/features/tasks/data/repositories/taskRepository_data.dart';
import 'package:time_tracker/features/tasks/domain/repositories/taskRepository_domain.dart';

final tasksProvider = StateNotifierProvider<TasksController, List<Task>>((ref) {
  //getting the hive box like before
  final Box box = ref.read(hiveBoxProvider);

  //wrappinig it in our datasource
  final hiveDataSource = HiveTaskDataSource(box);

  //wrapping THAT in our repository
  final TaskRepository repo = TaskRepositoryBase(hiveDataSource);

  //Giving the controller the repo instead of the box
  return TasksController(ref, repo);
});

class TasksController extends StateNotifier<List<Task>> {
  TasksController(this.ref, this.repo) : super(<Task>[]) {
    Future.microtask(_loadFromRepo);
  }

  final Ref ref;
  final TaskRepository repo;

  //static const String _boxKey = 'tasks';

  //-------------------------------------------------------------------------------------------------------

  Future<void> _saveToRepo() async {
    await repo.saveTasks(state);
  }

  Future<void> _loadFromRepo() async {
    final tasks = await repo.getAllTasks();
    state = tasks;
  }

  //-------------------------------------------------------------------------------------------------------

  final Map<String, Timer> _tickers = {};

  int _indexOf(String taskId) => state.indexWhere((t) => t.id == taskId);

  void _updateTask(String taskId, Task Function(Task) mutate) {
    final i = _indexOf(taskId);
    if (i == -1) return;
    final updated = mutate(state[i]);

    state = [...state.sublist(0, i), updated, ...state.sublist(i + 1)];
  }

  //ADDDDD
  Future<void> addTask({
    required String title,
    required List<String> details,
    required int totalMinutes,
    dynamic iconInfo,
  }) async {
    final newTask = Task(
      id: 't${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      details: details,
      iconInfo: iconInfo ?? 'assets/icons/monitor.png',
      totalMinutes: totalMinutes,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    );
    state = [newTask, ...state];
    await _saveToRepo();
  }

  void changeOrder({required Task latestTask}) {
    state = state.where((task) => task.id != latestTask.id).toList();
    state = [latestTask, ...state];
  }

  //-------------------------------------------------------------------------------------------------------
  //TIMER CONTROLSS
  Future<void> start(String taskId) async {
    await _stopOthers(taskId);
    if (_tickers[taskId] != null) {
      _tickers[taskId]!.cancel();
    }

    _updateTask(taskId, (t) {
      return t.copyWith(mode: TimerMode.running);
    });

    final currentTask = state.firstWhere((t) => t.id == taskId);
    changeOrder(latestTask: currentTask);

    //Stopping after reaching target time
    _tickers[taskId] = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTask(taskId, (t) {
        final int maxSeconds = t.totalMinutes * 60;
        final int next = t.elapsedSeconds + 1;
        if (next >= maxSeconds) {
          timer.cancel();
          _tickers.remove(taskId);
          return t.copyWith(
            elapsedSeconds: maxSeconds,
            mode: TimerMode.stopped,
          );
        }
        return t.copyWith(elapsedSeconds: t.elapsedSeconds + 1);
      });

      final task = state.firstWhere((t) => t.id == taskId);
      if (task.mode == TimerMode.running) {
        ref.read(statsProvider.notifier).tickNow();
      }
    });
  }

  Future<void> pause(String taskId) async {
    if (_tickers[taskId] != null) {
      _tickers[taskId]!.cancel();
    }
    _tickers.remove(taskId);
    _updateTask(taskId, (t) {
      return t.copyWith(mode: TimerMode.paused);
    });

    await _saveToRepo();
    await ref.read(statsProvider.notifier).saveToHive();
  }

  Future<void> stop(String taskId, {bool reset = false}) async {
    if (_tickers[taskId] != null) {
      _tickers[taskId]!.cancel();
    }

    _tickers.remove(taskId);

    _updateTask(taskId, (t) {
      int newElapsedSeconds;

      if (reset) {
        newElapsedSeconds = 0;
      } else {
        newElapsedSeconds = t.elapsedSeconds;
      }

      return t.copyWith(
        mode: TimerMode.stopped,
        elapsedSeconds: newElapsedSeconds,
      );
    });

    await _saveToRepo();
    await ref.read(statsProvider.notifier).saveToHive();
  }

  @override
  void dispose() {
    for (final timer in _tickers.values) {
      timer.cancel();
    }
    _tickers.clear();
    super.dispose();
  }

  //Using this to stop other tasks from running when we press start on one
  Future<void> _stopOthers(String playingTask) async {
    for (final task in state) {
      if (task.id == playingTask) continue;
      _tickers[task.id]?.cancel();
      _tickers.remove(task.id);
    }
    state = state.map((t) {
      if (t.id == playingTask) return t;
      if (t.mode == TimerMode.running) {
        return t.copyWith(mode: TimerMode.stopped);
      }
      return t;
    }).toList();

    await _saveToRepo();
    await ref.read(statsProvider.notifier).saveToHive();
  }

  Future<void> resetAllTimers() async {
    // 1) Build a new list with all timers = 0, mode = stopped
    final List<Task> newList = <Task>[];
    for (final t in state) {
      final Task reset = t.copyWith(elapsedSeconds: 0, mode: TimerMode.stopped);
      newList.add(reset);
    }

    // 2) Replace state with the reset list
    state = newList;

    // 3) Save tasks to Hive
    await _saveToRepo();

    // 4) Also clear graph stats so the chart is empty too
    await ref.read(statsProvider.notifier).clearAllStats();
  }
}

//-------------------------------------------------------------------------------------------------------
