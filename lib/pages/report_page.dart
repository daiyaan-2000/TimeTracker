import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:math' as math;

import 'package:time_tracker/widgets/report_overviewBox.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  overviewDetails: '1h 45m',
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

                            child: Icon(
                              Icons.show_chart,
                              size: 150,
                              color: Colors.grey,
                            ),
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

                            child: Icon(
                              Icons.show_chart,
                              size: 150,
                              color: Colors.deepPurpleAccent,
                            ),
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
