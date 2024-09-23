import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  const Location({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixNow!',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFFEBF4F6), // Text color EBF4F6
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF071952), // Background color #071952
        toolbarHeight: 100, // Blue filled space with the FixNow! text
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color(0xFFEBF4F6), // Set background color to EBF4F6
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Share your current location',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black, // Text color black
                  ),
                ),
                const SizedBox(height: 20.0), // Space between text and button

                // "SHARE" Button with teal background and white text
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF37B7C3), // Button filled with 37B7C3
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Add your sharing functionality here
                  },
                  child: const Text(
                    'SHARE',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFEBF4F6), // Text color EBF4F6
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