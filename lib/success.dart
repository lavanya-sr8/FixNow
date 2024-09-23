import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

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
              children: const <Widget>[
                // Removed the tick.png image
                SizedBox(height: 30.0), // Adjusted space after removing the image

                // "Successfully booked" text
                Text(
                  'Successfully booked',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37B7C3), // Text color same as button color (37B7C3)
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
