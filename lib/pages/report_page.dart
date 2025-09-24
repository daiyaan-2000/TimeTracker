import 'package:flutter/material.dart';
import 'package:time_tracker/pages/dashboard_page.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                length: 2,
                child: Column(
                  children: [
                    Container(
                      //decoration: BoxDecoration(color: Colors.white),
                      child: TabBar(
                        tabs: [
                          Tab(text: 'Hello'),
                          Tab(text: 'World'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Text('This is the dayy tab'),
                          Text('This is the week tab'),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      centerTitle: true,
      elevation: 0,
      leading: Icon(Icons.home),
      actions: [
        Icon(Icons.notification_add),
        SizedBox(width: 20),
        Icon(Icons.person),
        SizedBox(width: 20),
        Icon(Icons.settings),
        SizedBox(width: 20),
      ],
      title: Text(
        'Productivity Report',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          wordSpacing: 8,
        ),
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
