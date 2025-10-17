import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/task_provider.dart'; // for tasksProvider
import 'package:time_tracker/providers/tasks.dart'; // for TimerMode enum

class StatsController extends StateNotifier<Map<int, int>> {
  StatsController(this.ref) : super(<int, int>{});

  final Ref ref;

  void tickNow() {
    final int currentHour = DateTime.now().hour;
    final bool isRunning = ref.read(tasksProvider).any((t) {
      return t.mode == TimerMode.running;
    });

    if (isRunning == false) {
      return;
    }

    final int oldSeconds = state[currentHour] ?? 0;

    final Map<int, int> updated = Map<int, int>.from(state);

    updated[currentHour] = oldSeconds + 1;
    state = updated;
  }
}

final statsProvider = StateNotifierProvider<StatsController, Map<int, int>>((
  ref,
) {
  return StatsController(ref);
});
