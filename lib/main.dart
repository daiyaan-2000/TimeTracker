import 'package:flutter/material.dart';
import 'package:time_tracker/pages/opening_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Rubik',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 57, 134, 207),
        ),
      ),
      home: OpeningPage(),
    );
  }
}
