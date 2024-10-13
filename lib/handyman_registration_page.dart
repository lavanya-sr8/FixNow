import 'package:FixNow/handyman_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:firebase_messaging/firebase_messaging.dart'; 
import 'package:shared_preferences/shared_preferences.dart';// FCM import


class HandymanRegistrationPage extends StatefulWidget {
  const HandymanRegistrationPage({super.key});

  @override
  _HandymanRegistrationPageState createState() => _HandymanRegistrationPageState();
}

class _HandymanRegistrationPageState extends State<HandymanRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _experienceController = TextEditingController(); // New experience controller
  final _servicesController = TextEditingController(); // New services controller
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? _fcmToken; // Variable to store the FCM token

  @override
  void initState() {
    super.initState();
    _getFCMToken(); // Retrieve the FCM token when the widget is initialized
  }

  // Function to get FCM token
  Future<void> _getFCMToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $_fcmToken"); // Log the token (optional)
  }
  
  // Function to handle Firestore data submission
  Future<void> _registerHandyman() async {
    
    if (_formKey.currentState!.validate()) {
      // Firestore collection reference
      CollectionReference handymanProfile = FirebaseFirestore.instance.collection('handy_profile');

      // Add data to Firestore and get the document reference
      DocumentReference handymanDocRef = await handymanProfile.add({
        'name': _nameController.text,
        'address': _addressController.text,
        'qualification': _qualificationController.text,
        'experience': _experienceController.text, // Save experience field
        'services':_servicesController.text.split(',').map((s) => s.trim()).toList(), // Save services as an array
        'fcmToken': _fcmToken, // Include the FCM token here
      });

      // Now save the FCM token
      if (_fcmToken != null) {
        await handymanDocRef.update({
          'fcmToken': _fcmToken, // Include the FCM token here
        });
      }

      // Store registration status in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isHandymanRegistered', true);

      // Show success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Handyman registered successfully!')),
      );

      // Clear the form fields after successful registration
      _nameController.clear();
      _addressController.clear();
      _qualificationController.clear();
      _experienceController.clear();
      _servicesController.clear();


      // Navigate to Handyman Dashboard after successful registration
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HandymanDashboard()), // Replace with your HandymanDashboard page
    );
    }
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: EdgeInsets.zero,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20.0),
            child: Form( // Wrap fields in a Form widget for validation
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      hintText: 'Enter your address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                   const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _qualificationController,
                    decoration: const InputDecoration(
                      labelText: 'Qualification',
                      hintText: 'Enter your qualification',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your qualification';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _experienceController, // New Experience field
                    decoration: const InputDecoration(
                      labelText: 'Experience',
                      hintText: 'Enter your experience in years',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your experience';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _servicesController,
                    decoration: const InputDecoration(
                      labelText: 'Services',
                      hintText: 'Enter services offered (comma separated)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the services you provide';
                      }
                      return null;
                    },
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _registerHandyman, // Call the Firestore save function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 30, 209, 226),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF071952), 
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: const Center(
        child: Text(
          'FixNow!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
     ),
);
}
}





