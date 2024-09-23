import 'package:FixNow/success.dart';
import 'package:flutter/material.dart';

class Verify extends StatelessWidget {
  const Verify({super.key});

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
                // User information box
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: const Text(
                      'User: abc\nDate: 23-04-2024\nTime: 5:30 PM\nAddress: xyz',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0), // Space before buttons

                // Accept and Reject buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Success()),
                        );
                        // Accept button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        // Button color
                      ),
                      child: const Text(
                        'Accept',
                        style:
                            TextStyle(color: Color(0xFFEBF4F6)), // Text color
                      ),
                    ),
                    const SizedBox(width: 20), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        // Reject button action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B4D8),
                        // Button color
                      ),
                      child: const Text(
                        'Reject',
                        style:
                            TextStyle(color: Color(0xFFEBF4F6)), // Text color
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
