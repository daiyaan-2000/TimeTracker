import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:time_tracker/features/tasks/domain/usecases/saveTasks.dart';
import 'dart:async';
import 'package:time_tracker/providers/graphStatsProvider.dart';
import 'package:hive_ce/hive.dart';
import 'hiveBoxProvider.dart';
import 'package:time_tracker/features/tasks/data/datasources/hive_task_datasource.dart';
import 'package:time_tracker/features/tasks/domain/entities/tasks.dart';
import 'package:time_tracker/features/tasks/domain/repositories/task_repository.dart';
import 'package:time_tracker/features/tasks/data/repositories/hive_task_repository.dart';
import 'package:time_tracker/features/tasks/domain/usecases/addTask.dart';

final tasksProvider = StateNotifierProvider<TasksProvider, List<Task>>((ref) {
  final Box box = ref.read(hiveBoxProvider);

  final dataSource = HiveTaskDataSource(
    box,
  ); // Create the data source and pass it to the provider
  final repo = HiveTaskRepository(
    dataSource,
  ); // Build repository (domain-facing) on top of data source
  final getAllTasksUseCase = GetAllTasksUseCase(repo);
  final saveTasksUseCase = SaveTasksUseCase(repo);
  final addTaskUseCase = AddTaskUseCase(repo);

  return TasksProvider(
    ref,
    repo,
    getAllTasksUseCase,
    saveTasksUseCase,
    addTaskUseCase,
  );
});

class TasksProvider extends StateNotifier<List<Task>> {
  TasksProvider(
    this.ref,
    this.repo,
    this.getAllTasksUseCase,
    this.saveTasksUseCase,
    this.addTaskUseCase,
  ) : super(<Task>[]) {
    Future.microtask(_loadFromRepo);
  }

  final Ref ref;
  final TaskRepository repo;
  final GetAllTasksUseCase getAllTasksUseCase;
  final SaveTasksUseCase saveTasksUseCase;
  final AddTaskUseCase addTaskUseCase;

  //-------------------------------------------------------------------------------------------------------

  Future<void> _saveToRepo() async {
    await saveTasksUseCase(state);
  }

  Future<void> _loadFromRepo() async {
    final tasks = await getAllTasksUseCase();

    if (tasks.isEmpty) {
      state = _seedTasks();
      await saveTasksUseCase(state);
    } else {
      state = tasks;
    }
  }

  //-------------------------------------------------------------------------------------------------------

  static List<Task> _seedTasks() => [
    Task(
      id: 't1',
      title: 'Riverpod Project',
      details: ['Work', 'UI Design'],
      iconInfo: 'assets/icons/monitor.png',
      totalMinutes: 60,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    ),
    Task(
      id: 't2',
      title: 'Dart Language Training',
      details: ['Loops', 'Conditionals', 'Widgets'],
      iconInfo: 'assets/icons/monitor.png',
      totalMinutes: 60,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    ),
    Task(
      id: 't3',
      title: 'Footy Practice',
      details: ['Drills', 'Matches'],
      iconInfo: 'assets/icons/monitor.png',
      totalMinutes: 60,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    ),
  ];

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
    final updatedTasks = await addTaskUseCase(
      currentTasks: state,
      title: title,
      details: details,
      totalMinutes: totalMinutes,
      iconInfo: iconInfo,
    );

    state = updatedTasks;
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
