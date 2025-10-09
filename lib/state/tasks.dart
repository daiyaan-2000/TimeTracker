class Task {
  final String id;
  final String title;
  final List<String> details;
  final dynamic iconInfo;
  final int totalMinutes;
  final String timerText;

  const Task({
    required this.id,
    required this.title,
    required this.details,
    required this.iconInfo,
    required this.totalMinutes,
    required this.timerText,
  });

  Task copyWith({
    String? id,
    String? title,
    List<String>? details,
    dynamic iconInfo,
    int? totalMinutes,
    String? timerText,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      iconInfo: iconInfo ?? this.iconInfo,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      timerText: timerText ?? this.timerText,
    );
  }
}
