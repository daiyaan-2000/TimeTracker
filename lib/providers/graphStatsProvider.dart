import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/providers/tasks.dart';
import 'package:hive_ce/hive.dart';
import 'package:time_tracker/providers/hiveBoxProvider.dart';

class StatsController extends StateNotifier<Map<String, Map<int, int>>> {
  StatsController(this.ref, this.box) : super(<String, Map<int, int>>{}) {
    Future.microtask(_loadFromHive);
  }

  final Ref ref;
  final Box box;
  static const String _boxKey = 'stats_by_day';

  String _datetime(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  void tickNow() {
    final int currentHour = DateTime.now().hour;

    //if no task is running, do nothing.
    final List<Task> tasks = ref.read(tasksProvider);
    bool isRunning = false;
    for (final t in tasks) {
      if (t.mode == TimerMode.running) {
        isRunning = true;
        break;
      }
    }
    if (isRunning == false) {
      return;
    }

    //Todays date
    final String todayKey = _datetime(DateTime.now());

    //Map inside todays date
    Map<int, int>? existingMap = state[todayKey];

    Map<int, int> todayMap;
    if (existingMap != null) {
      todayMap = Map<int, int>.from(existingMap);
    } else {
      todayMap = {};
    }

    //Old seconds for this current hour
    final int oldSeconds = todayMap[currentHour] ?? 0;
    final int newSeconds = oldSeconds + 1;
    todayMap[currentHour] = newSeconds;

    //Overwrite todays entry
    final Map<String, Map<int, int>> newState = Map<String, Map<int, int>>.from(
      state,
    );
    newState[todayKey] = todayMap;

    state = newState;
  }

  Future<void> _loadFromHive() async {
    final dynamic raw = box.get(_boxKey);
    if (raw == null) {
      //EMpty state
      return;
    }

    final Map<String, Map<int, int>> rebuilt = {};

    if (raw is Map) {
      //at the moment raw looks smthn like { "2025-01-20": { 10: 540, 11: 120 }, ... }
      for (final entry in raw.entries) {
        final String dateKey = entry.key.toString();

        //Each inner value is a map/dict
        final innerRaw = entry.value;
        final Map<int, int> innerMap = {};

        if (innerRaw is Map) {
          for (final innerEntry in innerRaw.entries) {
            //here inner key might be int or string
            final int hour = int.parse(innerEntry.key.toString());
            final int seconds = (innerEntry.value as num).toInt();
            innerMap[hour] = seconds;
          }
        }

        rebuilt[dateKey] = innerMap;
      }
    }

    state = rebuilt;
  }

  Future<void> saveToHive() async {
    // Convert Map<String, Map<int,int>> -> Map<String, Map<String,int>>
    final Map<String, Map<String, int>> payload = {};

    // Outer loop: dates
    state.forEach((dateKey, innerMap) {
      final Map<String, int> out = {};

      // Inner loop: hours
      innerMap.forEach((hour, secs) {
        out[hour.toString()] =
            secs; // hour must be a String for Hive JSON-like storage
      });

      payload[dateKey] = out;
    });

    await box.put(_boxKey, payload);
  }

  Future<void> clearAllStats() async {
    // 1) Clear in-memory state: {}
    state = <String, Map<int, int>>{};

    // 2) Clear on-disk value (same key we used to save)
    //    You can either delete the key or write an empty map. Both are fine.
    //    Option A: delete the key entirely:
    await box.delete(_boxKey);

    //    Option B (also fine): keep the key but empty value:
    // await box.put(_boxKey, <String, Map<String, int>>{});
  }
}

final statsProvider =
    StateNotifierProvider<StatsController, Map<String, Map<int, int>>>((ref) {
      final box = ref.read(hiveBoxProvider);
      return StatsController(ref, box);
    });
