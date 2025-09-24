import 'package:flutter/material.dart';

enum TimerMode { stopped, running, paused }

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  TimerMode timerState = TimerMode.stopped;
  @override
  Widget build(BuildContext context) {
    Widget TimerControls() {
      if (timerState == TimerMode.stopped) {
        return Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                timerState = TimerMode.running;
              });
            },
            child: TimerButton(buttonTitle: 'START'),
          ),
        );
      } else if (timerState == TimerMode.running) {
        return Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  timerState = TimerMode.paused;
                });
              },
              child: TimerButton(buttonTitle: 'PAUSE'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  timerState = TimerMode.stopped;
                });
              },
              child: TimerButton(buttonTitle: 'STOP'),
            ),
          ],
        );
      } else {
        return Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  timerState = TimerMode.running;
                });
              },
              child: TimerButton(buttonTitle: 'RESUME'),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  timerState = TimerMode.stopped;
                });
              },
              child: TimerButton(buttonTitle: 'END'),
            ),
          ],
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 87, 110),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: 400,
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 95, 159, 184),
                width: 10,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent.withOpacity(0.2),
                  spreadRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'Timer is ${timerState.name}',
              style: const TextStyle(color: Colors.white, fontSize: 32),
            ),
          ),
          SizedBox(height: 64),

          TimerControls(),
        ],
      ),
    );
  }
}

class TimerButton extends StatelessWidget {
  const TimerButton({super.key, required this.buttonTitle});

  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      alignment: Alignment.center,
      height: 75,
      decoration: BoxDecoration(),
      child: Text(buttonTitle, style: TextStyle(fontSize: 16)),
    );
  }
}
