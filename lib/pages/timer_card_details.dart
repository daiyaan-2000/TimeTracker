import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:time_tracker/widgets/task_descriptions.dart';
import 'dart:math' as math;
import 'dart:async';

enum TimerMode { stopped, running, paused }

class TimerDetailPage extends StatefulWidget {
  final String title;
  final String timer;
  final List details;
  final int totalTaskMinutes;

  TimerDetailPage({
    super.key,
    required this.title,
    required this.timer,
    required this.details,
    required this.totalTaskMinutes,
  });

  @override
  State<TimerDetailPage> createState() => _TimerDetailPageState();
}

class _TimerDetailPageState extends State<TimerDetailPage> {
  final Color randomColor = Color(
    (math.Random().nextDouble() * 0xFFFFFF).toInt(),
  );

  static Duration elapsed = Duration.zero;
  static Timer? ticker;
  TimerMode timerState = TimerMode.stopped;

  String get _mmss {
    final m = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  //PAUSE PLAY START FEATURES
  void _start() {
    setState(() => timerState = TimerMode.running);

    ticker?.cancel();

    //ticker ticks every second
    ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed += const Duration(seconds: 1); //Adds one second each tick
      });
    });
  }

  void _pause() {
    ticker?.cancel();

    setState(() => timerState = TimerMode.paused);
  }

  void _resume() {
    //Like start except the resetting
    setState(() => timerState = TimerMode.running);

    ticker?.cancel();
    ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        elapsed += const Duration(seconds: 1);
      });
    });
  }

  void _stop() {
    ticker?.cancel();
    setState(() {
      timerState = TimerMode.stopped;
    });

    // Send back the new task info when stopping
    Navigator.pop(context, {});
  }

  @override
  void dispose() {
    ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> parts = widget.timer.split(":"); // ["32", "15"]

    final split = _mmss.split(':'); // ['03', '45']
    final mins = int.tryParse(split[0]) ?? 0;
    final secs = int.tryParse(split[1]) ?? 0;

    final totalSeconds = (mins * 60) + secs;
    final percent = (totalSeconds / (widget.totalTaskMinutes * 60)).clamp(
      0.0,
      1.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          Row(
            spacing: 6,
            children: [
              if (widget.details.isNotEmpty)
                TaskDescriptions(
                  label: widget.details.first,
                  color: Colors.deepPurpleAccent,
                ),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.fiber_manual_record_outlined,
                  color: Colors.deepPurpleAccent,
                ),
                SizedBox(width: 12),
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            //SizedBox(height: 80),
            CircularPercentIndicator(
              linearGradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 179, 155, 246),
                  Colors.deepPurpleAccent,
                  const Color.fromARGB(255, 86, 29, 241),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              circularStrokeCap: CircularStrokeCap.round,
              radius: 110,
              //progressColor: Colors.deepPurpleAccent,
              backgroundColor: const Color.fromARGB(255, 225, 224, 224),
              percent: percent,
              lineWidth: 20,
              //animation: true,
              center: Text(
                _mmss,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
            ),

            //SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _start,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(32, 32),
                        shape: CircleBorder(),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(233, 233, 255, 100),
                        radius: 32,
                        child: Icon(
                          Icons.play_arrow,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _pause,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(32, 32),
                        shape: CircleBorder(),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(233, 233, 255, 100),
                        radius: 32,
                        child: Icon(Icons.stop, size: 32, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
