import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/graphStatsProvider.dart';
import 'package:fl_chart/fl_chart.dart';

class WeekChart extends ConsumerWidget {
  const WeekChart({super.key});

  // Same date format we use as keys in StatsController: "YYYY-MM-DD"
  String _dateKey(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }

  // Compute the Monday of the current week
  DateTime _startOfWeek(DateTime now) {
    // DateTime.weekday: Mon=1 ... Sun=7
    final int daysFromMonday = now.weekday - DateTime.monday; // 0..6
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: daysFromMonday));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Shape reminder:
    // allStats = { "YYYY-MM-DD": { 10: 540, 11:120, ... }, ... }
    final Map<String, Map<int, int>> allStats = ref.watch(statsProvider);

    // 1) Get the 7 dates for this week (Mon..Sun), as strings "YYYY-MM-DD"
    final DateTime today = DateTime.now();
    final DateTime monday = _startOfWeek(today);

    final List<String> weekKeys = <String>[];
    for (int i = 0; i < 7; i++) {
      final d = monday.add(Duration(days: i));
      weekKeys.add(_dateKey(d));
    }

    // 2) For each day, sum the seconds in the inner map
    // totalsSecondsByDay[i] = total seconds for that weekday
    final List<int> totalsSecondsByDay = <int>[];
    for (final key in weekKeys) {
      final Map<int, int>? inner = allStats[key];
      int sum = 0;
      if (inner != null) {
        // inner = {hour:int -> seconds:int}
        for (final secs in inner.values) {
          sum += secs;
        }
      }
      totalsSecondsByDay.add(sum);
    }

    // Labels for x-axis: index 0 = Mon, ... 6 = Sun
    final List<String> weekdayLabels = <String>[
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];

    // Build one bar per weekday
    final List<BarChartGroupData> barGroups = <BarChartGroupData>[];

    for (
      int weekdayIndex = 0;
      weekdayIndex < totalsSecondsByDay.length;
      weekdayIndex++
    ) {
      final int seconds = totalsSecondsByDay[weekdayIndex];
      final double minutes = seconds / 60.0;

      barGroups.add(
        BarChartGroupData(
          x: weekdayIndex, // 0..6
          barRods: [
            BarChartRodData(
              toY: minutes,
              width: 14,
              borderRadius: BorderRadius.circular(6),
              color: const Color(
                0xFF6C3BFF,
              ), // same purple we used in day chart
            ),
          ],
        ),
      );
    }

    // TEMP: print so we can verify before drawing any chart
    debugPrint('Week keys: $weekKeys');
    debugPrint('Totals (seconds) Mon..Sun: $totalsSecondsByDay');

    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          alignment: BarChartAlignment.spaceAround,

          // set a nice upper bound for minutes on Y axis
          maxY: 120, // 2 hours = 120 minutes. adjust later if you work more!

          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),

          titlesData: FlTitlesData(
            // LEFT (Y axis): show 0, 60, 120
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 60, // every 60 minutes
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}m', // "60m"
                    style: const TextStyle(fontSize: 10, color: Colors.black87),
                  );
                },
              ),
            ),

            // BOTTOM (X axis): Mon Tue Wed Thu Fri Sat Sun
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  if (index < 0 || index >= weekdayLabels.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    weekdayLabels[index],
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  );
                },
              ),
            ),

            // turn off top/right axes
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
        ),
      ),
    );
    ;
  }
}
