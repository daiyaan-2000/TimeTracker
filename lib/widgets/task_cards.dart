import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
import 'package:time_tracker/pages/timer_card_details.dart';
import 'package:time_tracker/widgets/task_descriptions.dart';

class TaskCards extends StatelessWidget {
  TaskCards({
    super.key,
    required this.iconInfo,
    required this.title,
    required this.timer,
    this.details = const [],
    required this.minutes,
  });

  final iconInfo;
  final String title;
  final String timer;
  final List<String> details;
  final int minutes;
  final Color randomColor = Color(
    (math.Random().nextDouble() * 0xFFFFFF).toInt(),
  );

  @override
  Widget build(BuildContext context) {
    //final String iconFile = 'assets/icons/$iconInfo';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        //borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TimerDetailPage(
                title: title,
                timer: timer,
                details: details,
                totalTaskMinutes: minutes,
              ),
            ),
          );
        },

        child: Container(
          //1
          margin: EdgeInsets.only(bottom: 16),
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(12),
            /*boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                spreadRadius: 1,
                offset: Offset(0, 1),
              ),
            ],*/
          ),
          child: Row(
            //2
            //spacing: 16,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Row(
                  //3
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: randomColor.withOpacity(1.0),
                      radius: 22,
                      child: iconInfo.runtimeType == IconData
                          ? Icon(iconInfo, color: Colors.white)
                          : ImageIcon(
                              AssetImage(iconInfo),
                              color: Colors.white,
                            ),
                    ),

                    Expanded(
                      child: Column(
                        //4
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),

                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              for (var i in details)
                                TaskDescriptions(label: i, color: randomColor),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Flexible(
                child: Column(
                  //6
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      timer,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 8),
                    Icon(
                      Icons.play_arrow_rounded,
                      size: 32,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
