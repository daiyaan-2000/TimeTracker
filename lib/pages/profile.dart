import 'package:flutter/material.dart';
import 'package:time_tracker/widgets/profile_page_buttons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 246, 253),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Color.fromARGB(255, 27, 87, 110),
            child: Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage('assets/logo.png')),
                ),
              ),
            ),
          ),

          SizedBox(height: 32),
          profilePageButtons(buttonText: 'Edit profile'),
          profilePageButtons(buttonText: 'Settings'),
          profilePageButtons(buttonText: 'User guide'),
          profilePageButtons(buttonText: 'FAQ'),
        ],
      ),
    );
  }
}
