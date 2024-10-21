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
            color: Colors.white, // Title text color changed to white
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Header color changed
        toolbarHeight: 100, // Blue filled space with the FixNow! text
        iconTheme: const IconThemeData(color: Colors.white), // Icon color changed to white
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: const Color(0xFFE7F6F2), // Page color changed to E7F6F2
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
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
          // Watermark Container
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Watermark opacity
              child: Container(
                width: 800.0,
                height: 800.0,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/fixnow_dark.png'),
                    fit: BoxFit.cover,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 25,
                      blurRadius: 120,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
