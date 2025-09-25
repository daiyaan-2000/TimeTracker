import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/app_bar.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myappBar('Productivity Report'),
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 16,
              children: [
                //-----------------------FIRST BOX-------------------------------------------------
                OverViewBox(
                  iconData: Icons.task,
                  title: 'Tasks Completed',
                  tasksCompleted: '12',
                ),

                //-----------------------FIRST BOX-------------------------------------------------
                OverViewBox(
                  iconData: Icons.timer,
                  title: 'Time Duration',
                  tasksCompleted: '1h 45m',
                ),
              ],
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 300,
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Container(
                      //decoration: BoxDecoration(color: Colors.white),
                      child: TabBar(
                        tabs: [
                          Tab(text: 'Day'),
                          Tab(text: 'Week'),
                          Tab(text: 'Month'),
                          Tab(text: 'Year'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        //QUESTION: How does it know which TabBar to check? What if there were two tabbars?
                        children: [
                          ImageContainer(imageUrl: 'assets/day.png'),
                          ImageContainer(imageUrl: 'assets/week.png'),
                          ImageContainer(imageUrl: 'assets/month.png'),
                          ImageContainer(imageUrl: 'assets/year.png'),
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
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  minRadius: 24,
                  backgroundColor: Color.fromARGB(255, 27, 87, 110),
                  child: Icon(iconData, color: Colors.white, size: 24),
                ),
                Expanded(
                  //alignment: WrapAlignment.start,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              tasksCompleted,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
