import 'package:codeverse/userpage.dart';
import 'package:flutter/material.dart';

import 'adminpage.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for hacker vibe
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hacker-style header text
            Text(
              'Select Your Role',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.greenAccent, // Matrix green color
                fontFamily: 'Courier', // Terminal-style font
              ),
            ),
            SizedBox(height: 30), // Add some space between title and buttons
            // Hacker-style User button
            GestureDetector(
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.greenAccent, // Glowing border
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.8), // Neon glow
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'User',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage()));
              },
            ),
            SizedBox(height: 20), // Space between buttons
            // Hacker-style Admin button
            GestureDetector(
              child: Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.greenAccent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'Courier',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Adminpage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
