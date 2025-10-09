import 'package:flutter/material.dart';
import 'package:time_tracker/pages/opening_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
