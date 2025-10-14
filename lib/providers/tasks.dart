enum TimerMode { stopped, running, paused }

class Task {
  final String id;
  final String title;
  final List<String> details;
  final dynamic iconInfo;
  final int totalMinutes;
  //final String timerText;

  final int elapsedSeconds;
  final TimerMode mode;

  const Task({
    required this.id,
    required this.title,
    required this.details,
    required this.iconInfo,
    required this.totalMinutes,
    //required this.timerText,
    this.elapsedSeconds = 0,
    this.mode = TimerMode.stopped,
  });

  Task copyWith({
    String? id,
    String? title,
    List<String>? details,
    dynamic iconInfo,
    int? totalMinutes,
    int? elapsedSeconds,
    TimerMode? mode,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      iconInfo: iconInfo ?? this.iconInfo,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      //timerText: timerText ?? this.timerText,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      mode: mode ?? this.mode,
    );
  }

  String get timerText {
    final m = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get percentOfGoal {
    final total = (totalMinutes * 60).clamp(1, 1 << 31); // avoid divide-by-zero
    return (elapsedSeconds / total).clamp(0, 1);
  }
}
