import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:time_tracker/providers/graphStatsProvider.dart';

class ReportChartStats extends ConsumerWidget {
  const ReportChartStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

    //Making the data usable for FL Chart
    final dataPoints = stats.entries.map((entry) {
      final hour = entry.key.toDouble();
      final minutes = (entry.value / 60).toDouble();
      return FlSpot(hour, minutes);
    }).toList();

    print('Data points: $dataPoints');

    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(child: Text('Chart will appear here')),
    );
  }
}
