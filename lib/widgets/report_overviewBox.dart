import 'dart:math' as math;
import 'package:flutter/material.dart';

class OverViewBox extends StatelessWidget {
  const OverViewBox({
    super.key,
    required this.iconInfo,
    required this.title,
    required this.tasksCompleted,
  });

  final iconInfo;

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
                  child: iconInfo.runtimeType == IconData
                      ? Icon(iconInfo, color: Colors.white, size: 24)
                      : ImageIcon(
                          AssetImage(iconInfo),
                          color: Colors.white,
                          size: 24,
                        ),
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
