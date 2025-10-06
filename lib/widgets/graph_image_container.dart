import 'package:flutter/material.dart';

class GraphImageContainer extends StatelessWidget {
  const GraphImageContainer({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Color.fromARGB(255, 27, 87, 110)),
        ),
        padding: EdgeInsets.all(10),
        child: Image.asset(imageUrl),
      ),
    );
  }
}
