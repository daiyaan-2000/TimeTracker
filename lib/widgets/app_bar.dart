import 'package:flutter/material.dart';

AppBar myappBar(String page_header) {
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
      page_header,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        wordSpacing: 8,
      ),
    ),
  );
}
