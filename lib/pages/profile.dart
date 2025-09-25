import 'package:flutter/material.dart';

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
          profileButtons(buttonText: 'Edit profile'),
          profileButtons(buttonText: 'Settings'),
          profileButtons(buttonText: 'User guide'),
          profileButtons(buttonText: 'FAQ'),
        ],
      ),
    );
  }
}

class profileButtons extends StatelessWidget {
  const profileButtons({super.key, required this.buttonText});

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,

      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color.fromARGB(255, 237, 249, 254),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
