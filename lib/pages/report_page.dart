import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracker/providers/hiveBoxProvider.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'package:time_tracker/widgets/dayGraphChart.dart';
import 'package:time_tracker/widgets/reportChartStats.dart';
import 'dart:math' as math;

import 'package:time_tracker/widgets/report_overviewBox.dart';
import 'package:time_tracker/widgets/weekGraphChart.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(tasksProvider);
    double timeSum = 0;
    final hiveList = ref.watch(hiveBoxProvider);

    final List hiveMap = hiveList.get('tasks');

    for (final i in hiveMap) {
      timeSum += i['elapsedSeconds'];
    }

    int timeSumMinutes = timeSum ~/ 60;
    int timeSumSeconds = (timeSum % 60).toInt();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Productivity Report',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(250, 250, 255, 100),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //In figma, how is the spacing between boxes 15, but the spacing in each side 16?
              spacing: 15,
              children: [
                //-----------------------FIRST BOX-------------------------------------------------
                OverViewBox(
                  iconInfo: Icons.check,
                  title: 'Tasks Completed',
                  overviewDetails: '12',
                ),

                //-----------------------FIRST BOX-------------------------------------------------
                OverViewBox(
                  iconInfo: 'assets/icons/stopwatch.png',
                  title: 'Time Duration',
                  overviewDetails: '${timeSumMinutes}m ${timeSumSeconds}s',
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 300,
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 255, 100),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TabBar(
                        tabs: [
                          Tab(text: 'Day'),
                          Tab(text: 'Week'),
                        ],
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.black,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),

                        unselectedLabelColor: Colors.grey,
                        dividerColor: Colors.transparent,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        //QUESTION: How does it know which TabBar to check? What if there were two tabbars?
                        children: [
                          Container(
                            height: 500,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            margin: EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 16,
                            ),

                            child: DayChart(),
                          ),
                          Container(
                            height: 500,
                            width: 200,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),

                            margin: EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 16,
                            ),

                            child: WeekChart(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
