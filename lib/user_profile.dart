import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

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
      body: SingleChildScrollView( // Added to allow scrolling
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Input for name
              const SizedBox(
                width: 300, // Adjust width as per your preference
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF37B7C3), // Set the focused border color
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF37B7C3), // Change label color when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Input for phone number
              const SizedBox(
                width: 300, // Adjust width as per your preference
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Enter your phone number',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF37B7C3), // Set the focused border color
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF37B7C3), // Change label color when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input for email
               const SizedBox(
                width: 300, // Adjust width as per your preference
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Enter your email ID',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF37B7C3), // Set the focused border color
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF37B7C3), // Change label color when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Input for Aadhaar number
               const SizedBox(
                width: 300, // Adjust width as per your preference
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your Aadhaar number',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF37B7C3), // Set the focused border color
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF37B7C3), // Change label color when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               // Input for address
              const SizedBox(
                width: 300, // Adjust width as per your preference
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter your address',
                    labelStyle: TextStyle(color: Colors.grey), // Default label color
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF37B7C3), // Set the focused border color
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color(0xFF37B7C3), // Change label color when focused
                    ),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3, // Allowing multi-line input for the address
                ),
              ),
              const SizedBox(height: 40),
               // SAVE button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF37B7C3), // Button filled with 37B7C3
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  // Add save functionality here
                },
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color(0xFFEBF4F6), // Text color EBF4F6
                  ),
                ),
              ),
            ],
          ),
        ),
     ),
);
}
}







