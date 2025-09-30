import 'package:flutter/material.dart';

AppBar myappBar(String pageHeader) {
  return AppBar(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
    centerTitle: true,
    elevation: 0,
    leading: Icon(Icons.arrow_back),
    actions: [],
    title: Text(
      pageHeader,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        wordSpacing: 8,
      ),
    ),
  );
}
