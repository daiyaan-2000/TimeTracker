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

  //--------------------------
  //Converting Task type to fit HiveBox
  //--------------------------

  //Turning Task into a plain Map for Hive storage
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'details': details, // List<String> stores fine
      'iconInfo': iconInfo,
      'totalMinutes': totalMinutes,
      'elapsedSeconds': elapsedSeconds,
      'mode': timerModeToString(mode),
    };
  }

  //Builting Task back from Map in Hive storage
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      details: List<String>.from(map['details'] as List),
      iconInfo: map['iconInfo'],
      totalMinutes: map['totalMinutes'] as int,
      elapsedSeconds: (map['elapsedSeconds'] as num).toInt(),
      mode: timerModeFromString(map['mode'] as String),
    );
  }
}

//--------------------------
//Converting TimerMode to String and back for HiveBox
//--------------------------

String timerModeToString(TimerMode m) {
  switch (m) {
    case TimerMode.running:
      return 'running';
    case TimerMode.paused:
      return 'paused';
    case TimerMode.stopped:
      return 'stopped';
  }
}

TimerMode timerModeFromString(String s) {
  switch (s) {
    case 'running':
      return TimerMode.running;
    case 'paused':
      return TimerMode.paused;
    case 'stopped':
    default:
      return TimerMode.stopped;
  }
}
