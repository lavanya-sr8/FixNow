import 'package:FixNow/ser_handyman.dart';
import 'package:flutter/material.dart';

class Reject extends StatelessWidget {
  const Reject({super.key});
  
  get style => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' '),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Your Booking has been rejected.Please Retry',
              style: TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            // Add any additional information or actions for the user here
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ServHandyman()),
                        );
              },
              style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        // Button color
                      ),
              child: const Text('Back',style:
                            TextStyle(color: Color(0xFFEBF4F6)), ),
              
            ),
          ],
        ),
      ),
    );
  }
}