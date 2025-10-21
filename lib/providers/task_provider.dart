import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'tasks.dart';
import 'dart:async';
import 'package:time_tracker/providers/graphStatsProvider.dart';
import 'package:hive_ce/hive.dart';
import 'hiveBoxProvider.dart';

final tasksProvider = StateNotifierProvider<TasksController, List<Task>>((ref) {
  final Box box = ref.read(hiveBoxProvider);
  return TasksController(ref, box);
});

class TasksController extends StateNotifier<List<Task>> {
  TasksController(this.ref, this.box) : super(<Task>[]) {
    Future.microtask(_loadFromHive);
  }

  final Ref ref;
  final Box box;

  static const String _boxKey = 'tasks';

  //-------------------------------------------------------------------------------------------------------

  Future<void> _saveToHive() async {
    final List<Map<String, dynamic>> list = <Map<String, dynamic>>[];
    for (final i in state) {
      list.add(i.toMap());
    }
    await box.put(_boxKey, list);

    // DEBUG
    final first = list.isNotEmpty ? list.first : null;

    ;
  }

  Future<void> _loadFromHive() async {
    final dynamic raw = box.get(_boxKey);

    if (raw == null) {
      state = _seedTasks();
      await _saveToHive();
      return;
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

    if (loaded.isEmpty) {
      print('[LOAD] parsed 0 items -> seed & save');
      state = _seedTasks();
      await _saveToHive();
    } else {
      print(
        '[LOAD] loaded ${loaded.length} tasks. '
        'First: id=${loaded.first.id} elapsed=${loaded.first.elapsedSeconds} mode=${loaded.first.mode}',
      );
      state = loaded;
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
    await _saveToHive();
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

  void pause(String taskId) {
    if (_tickers[taskId] != null) {
      _tickers[taskId]!.cancel();
    }
    _tickers.remove(taskId);
    _updateTask(taskId, (t) {
      return t.copyWith(mode: TimerMode.paused);
    });

    _saveToHive();
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

    await _saveToHive();
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

    await _saveToHive();
  }
}

//-------------------------------------------------------------------------------------------------------
