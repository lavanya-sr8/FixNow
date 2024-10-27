import 'package:FixNow/home.dart';
import 'package:FixNow/main.dart';
import 'package:FixNow/ser_handyman.dart';
import 'package:flutter/material.dart';

class Dummy extends StatelessWidget {
  const Dummy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixNow!',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white, // Text color is now white
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Background color is now 2C3333
        toolbarHeight: 100, // Blue filled space with the FixNow! text
      ),
      body: Stack(
        children: <Widget>[
          // Set page background color to E7F6F2
          Container(
            color: const Color(0xFFE7F6F2), // Page color is now E7F6F2
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // "Service" Button with teal background and white text
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37B7C3), // Button filled with 37B7C3
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(userId: simId!),
                      ),
                    );
                  },
                  child: const Text(
                    'HOME',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFE7F6F2), // Text color is now E7F6F2
                    ),
                  ),
                ),
                const SizedBox(height: 20.0), // Space between buttons

                // "Handyman" Button with teal background and white text
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37B7C3), // Button filled with 37B7C3
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServHandyman(),
                      ),
                    );
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFE7F6F2), // Text color is now E7F6F2
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

