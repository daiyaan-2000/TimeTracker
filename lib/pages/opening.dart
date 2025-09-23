import 'package:flutter/material.dart';
import 'package:time_tracker/pages/home.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 27, 87, 110),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              //color: Colors.white,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: BoxBorder.all(color: Colors.black, width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 20,
                    blurRadius: 20,
                    offset: Offset(0, 3),
                  ),
                ],

                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'My first app UI',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 110),

            InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => HomePage()));
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  border: BoxBorder.all(color: Colors.black, width: 2),

                  color: Colors.white,
                ),
                child: Text(
                  'Press here to start',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
