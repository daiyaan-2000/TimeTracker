import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/graphStatsProvider.dart';
import 'package:fl_chart/fl_chart.dart';

class DayChart extends ConsumerWidget {
  const DayChart({super.key});

  String _hourLabel(int h) {
    final int hour12 =
        ((h + 11) % 12) + 1; //taking 0-23 and turning it into 1-12
    final String suffix = (h < 12) ? 'am' : 'pm';
    return '$hour12$suffix';
  }

  String _minutesLabel(double v) {
    // v is 0..60 (double). Show every 10 minutes: "0m", "10m", ...
    return '${v.toInt()}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //reading stats
    final Map<String, Map<int, int>> allStats = ref.watch(statsProvider);

    String _dateKey(DateTime d) {
      final y = d.year.toString().padLeft(4, '0');
      final m = d.month.toString().padLeft(2, '0');
      final day = d.day.toString().padLeft(2, '0');
      return '$y-$m-$day';
    }

    final String todayKey = _dateKey(DateTime.now());

    //Pull inner map from todays date
    final Map<int, int> stats = Map<int, int>.from(
      allStats[todayKey] ?? const <int, int>{},
    );

    //sorting out the hours
    final List<int> hours = stats.keys.toList()..sort();

    //converting stats to FLChart points (hour → minutes)
    final List<FlSpot> dataPoints = stats.entries.map((entry) {
      final int hour = entry.key;
      final int seconds = entry.value;
      final double minutes = seconds / 60.0;
      return FlSpot(hour.toDouble(), minutes);
    }).toList()..sort((a, b) => a.x.compareTo(b.x)); // sort left-to-right

    //UI
    return Container(
      height: 220,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: dataPoints.isEmpty
          ? const Center(child: Text('No work recorded yet'))
          : LineChart(
              LineChartData(
                minX: 9,
                maxX: 21,
                minY: 0,
                maxY: 60,

                gridData: FlGridData(
                  show: false,
                  drawVerticalLine: true,
                  verticalInterval: 1,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.25),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),

                  drawHorizontalLine: true,
                  horizontalInterval: 15,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.25),
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  ),
                ),

                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),

                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final h = value.toInt();
                        return Text(
                          '$h',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),

                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 36,
                      interval: 30,
                      getTitlesWidget: (value, meta) {
                        final m = value.toInt();
                        return Text(
                          '$m',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                rangeAnnotations: RangeAnnotations(
                  verticalRangeAnnotations: [
                    VerticalRangeAnnotation(
                      x1: DateTime.now().hour - 0.5,
                      x2: DateTime.now().hour + 0.5,
                      color: const Color(0xFF6C3BFF).withOpacity(0.10),
                    ),
                  ],
                ),

                lineBarsData: [
                  LineChartBarData(
                    spots: dataPoints,
                    isCurved: true,
                    belowBarData: BarAreaData(show: false),
                    aboveBarData: BarAreaData(show: false),
                    barWidth: 5,
                    color: const Color(0xFF6C3BFF),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6C3BFF),
                        const Color.fromARGB(255, 213, 200, 251),
                      ],
                    ),
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, bardata, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Color.fromARGB(255, 255, 255, 255),
                          strokeColor: Color.fromARGB(255, 123, 81, 249),
                          strokeWidth: 5,
                        );
                      },
                    ),
                  ),
                ],

                //gridData: FlGridData(show: true),
                //titlesData: FlTitlesData(show: false),
                //borderData: FlBorderData(show: false),
              ),
            ),
    );
  }
}
