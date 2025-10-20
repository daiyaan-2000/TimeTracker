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

  Future<void> _saveToHive() async {
    final List<Map<String, dynamic>> payload = state
        .map((t) => t.toMap())
        .toList();
    await box.put(_boxKey, payload);
  }

  Future<void> _loadFromHive() async {
    final dynamic raw = box.get(_boxKey);

    if (raw is List) {
      try {
        // Turn List<dynamic> -> List<Task>
        final List<Task> loaded = raw.map((e) {
          final map = Map<String, dynamic>.from(e as Map);
          return Task.fromMap(map);
        }).toList();

        state = loaded;
        return; // success
      } catch (e) {
        // If parsing fails, we’ll just fall back to seeding below.
        // You might log e in a real app.
      }
    }

    // Nothing saved yet (or bad data): use the seed once, then persist it
    state = _seedTasks();
    await _saveToHive();
  }

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
      iconInfo: Icons.language,
      totalMinutes: 60,
      elapsedSeconds: 0,
      mode: TimerMode.stopped,
    ),
    Task(
      id: 't3',
      title: 'Footy Practice',
      details: ['Drills', 'Matches'],
      iconInfo: Icons.sports_soccer,
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
  void addTask({
    required String title,
    required List<String> details,
    required int totalMinutes,
    dynamic iconInfo,
  }) {
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
  }

  void changeOrder({required Task latestTask}) {
    state = state.where((task) => task.id != latestTask.id).toList();
    state = [latestTask, ...state];
  }

  //TIMER CONTROLSS
  void start(String taskId) {
    _stopOthers(taskId);
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
  }

  void stop(String taskId, {bool reset = false}) {
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
  void _stopOthers(String playingTask) {
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
  }
}
