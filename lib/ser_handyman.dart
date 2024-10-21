import 'package:FixNow/handyman_registration_page.dart';
import 'package:flutter/material.dart';
import 'package:FixNow/service_selection_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'handyman_dashboard.dart'; // Import the handyman dashboard page

class ServHandyman extends StatelessWidget {
  const ServHandyman({super.key});

  // Function to check if handyman is registered and navigate accordingly
  Future<void> _navigateToHandymanPage(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRegistered = prefs.getBool('isHandymanRegistered');

    if (isRegistered == true) {
      // Navigate to Handyman Dashboard if registered
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HandymanDashboard()),
      );
    } else {
      // Navigate to Handyman Registration if not registered
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HandymanRegistrationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixNow!',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white, // Text color set to white
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Header color changed
        toolbarHeight: 100, // Blue filled space with the FixNow! text
      ),
      body: Container(
        color: const Color(0xFFE7F6F2), // Page color changed
        child: Center(
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
                  // Navigate to ServiceSelectionPage
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
                onPressed: () {
                  // Check registration status and navigate
                  _navigateToHandymanPage(context);
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
      ),
    );
  }
}
