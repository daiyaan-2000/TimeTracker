import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/app_bar.dart';
import 'dart:async';

enum TimerMode { stopped, running, paused }

class AddNew extends StatefulWidget {
  const AddNew({super.key});

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  TimerMode timerState = TimerMode.stopped;

  //STOPWATCH DEClARATIONS
  Duration _elapsed = Duration.zero;
  Timer? _ticker;

  String get _mmss {
    final m = _elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = _elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  //PAUSE PLAY START FEATURES
  void _start() {
    _elapsed = Duration.zero;

    setState(() => timerState = TimerMode.running);

    //If a timer was already running, stop it first (prevents duplicates).
    _ticker?.cancel();

    // Make a new "ticker" that fires every second.
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      // Each tick: add 1 second and redraw the UI (so the text updates).
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });
  }

  void _pause() {
    // Stop the ticker (time stops increasing)…
    _ticker?.cancel();
    // …but keep the elapsed time. We just change the mode.
    setState(() => timerState = TimerMode.paused);
  }

  void _resume() {
    // Same as start, but notice: we do NOT reset _elapsed.
    setState(() => timerState = TimerMode.running);

    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });
  }

  void _stop() {
    // Stop ticking…
    _ticker?.cancel();
    // …and reset everything to the initial state.
    setState(() {
      timerState = TimerMode.stopped;
      _elapsed = Duration.zero; // back to 00:00
    });
  }

  //UI DESIGN PART
  @override
  Widget build(BuildContext context) {
    Widget TimerControls() {
      if (timerState == TimerMode.stopped) {
        return Center(
          child: ElevatedButton(
            onPressed: _start, // <— call the start method
            style: ElevatedButton.styleFrom(minimumSize: const Size(160, 56)),
            child: const Text('START'),
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
              _mmss,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.w400,
              ),
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
