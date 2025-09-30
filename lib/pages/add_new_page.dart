import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/app_bar.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Add New Timer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(250, 250, 255, 100),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //spacing: 4,
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromRGBO(233, 233, 255, 100),
                ),
                margin: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter timer title',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'e.g: Flutter project',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 79, 138, 162),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48),
            ],
          ),
          Container(
            height: 250,
            width: 250,
            padding: EdgeInsets.all(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepPurpleAccent, width: 10),
              shape: BoxShape.circle,
              /*
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent.withOpacity(0.2),
                  spreadRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
              */
            ),
            child: Text(
              'Timer is ${timerState.name}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          SizedBox(height: 80),

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
