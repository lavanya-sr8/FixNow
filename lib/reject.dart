import 'package:FixNow/ser_handyman.dart';
import 'package:flutter/material.dart';

class Reject extends StatelessWidget {
  const Reject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Change header color
      ),
      body: Container(
        color: const Color(0xFFE7F6F2), // Change page color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Your Booking has been rejected. Please Retry',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 20.0),
              // Add any additional information or actions for the user here
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServHandyman(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B4D8), // Button color
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xFFEBF4F6)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
