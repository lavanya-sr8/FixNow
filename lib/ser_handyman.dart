import 'package:FixNow/handyman_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:FixNow/service_selection_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServHandyman extends StatelessWidget {
  const ServHandyman({super.key});

  // Function to check if the user is already registered as a handyman
  Future<bool> _isHandymanRegistered() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('user_profile').doc(uid).get();
      
      // Check if the 'isHandyman' field exists and is true
      if (userDoc.exists && userDoc['isHandyman'] == true) {
        return true;
      }
    }
    return false;
  }

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
            color: const Color.fromARGB(255, 255, 255, 255), // Set background color to EBF4F6
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // "Service" Button with teal background and white text
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B4D8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 70.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Service Selection page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServiceSelectionPage()),
                    );
                  },
                  child: const Text(
                    'Service',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFFEBF4F6), // Text color EBF4F6
                    ),
                  ),
                ),
                const SizedBox(height: 20.0), // Space between buttons

                // "Handyman" Button with teal background and white text
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00B4D8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 60.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () async {
                    // Check if the user is already a handyman
                    bool isHandyman = await _isHandymanRegistered();

                    if (isHandyman) {
                      // Show message if already registered as a handyman
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You are already registered as a handyman!')),
                      );

                      // Optionally, navigate to a different page (like profile or edit details)
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const EditHandymanProfilePage()));
                    } else {
                      // Navigate to Handyman Registration page if not registered
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HandymanRegistrationPage(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Handyman',
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
