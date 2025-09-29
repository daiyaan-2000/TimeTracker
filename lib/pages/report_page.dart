import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:math' as math;

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('My Productivity'),
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
                  iconData: Icons.check,
                  title: 'Tasks Completed',
                  tasksCompleted: '12',
                ),

                //-----------------------FIRST BOX-------------------------------------------------
                OverViewBox(
                  iconData: Icons.timer_outlined,
                  title: 'Time Duration',
                  tasksCompleted: '1h 45m',
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

class ImageContainer extends StatelessWidget {
  const ImageContainer({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Color.fromARGB(255, 27, 87, 110)),
        ),
        padding: EdgeInsets.all(10),
        child: Image.asset(imageUrl),
      ),
    );
  }
}

class OverViewBox extends StatelessWidget {
  const OverViewBox({
    super.key,
    required this.iconData,
    required this.title,
    required this.tasksCompleted,
  });

  final IconData iconData;

  final String title;

  final String tasksCompleted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 132,
        width: 164,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 32,
                  width: 32,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromARGB(
                      255, // full opacity
                      (math.Random().nextInt(128)), // red 0–127
                      (math.Random().nextInt(128)), // green 0–127
                      (math.Random().nextInt(128)), // blue 0–127
                    ),
                  ),
                  child: Icon(iconData, color: Colors.white, size: 24),
                ),
                Expanded(
                  //alignment: WrapAlignment.start,
                  child: Text(title, style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              tasksCompleted,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
