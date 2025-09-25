import 'package:flutter/material.dart';
import 'package:time_tracker/pages/dashboard_page.dart';
import 'package:time_tracker/widgets/botton_nav_bar.dart';

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
              height: 200,
              width: 400,
              //color: Colors.white,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: BoxBorder.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],

                color: Color.fromARGB(255, 226, 246, 253),
              ),
              child: Center(child: Image.asset('logo.png')),
            ),

            SizedBox(height: 110),

            InkWell(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => BottomNavBar()));
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
