import 'package:FixNow/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  // Controllers for each input field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  UserProfile({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Input for name
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
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
              SizedBox(
                width: 300,
                child: TextField(
                  controller: phoneNoController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Enter your phone number',
                    labelStyle: TextStyle(color: Colors.grey),
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
              SizedBox(
                width: 300,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Enter your email ID',
                    labelStyle: TextStyle(color: Colors.grey),
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
              SizedBox(
                width: 300,
                child: TextField(
                  controller: aadhaarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Aadhaar number',
                    labelStyle: TextStyle(color: Colors.grey),
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
              SizedBox(
                width: 300,
                child: TextField(
                  controller: addressController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Enter your address',
                    labelStyle: TextStyle(color: Colors.grey),
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
                onPressed: () async {
                  // Save functionality, using the values from controllers
                  CollectionReference collRef = FirebaseFirestore.instance.collection('user_profile');
                  
                  // Adding data to Firestore
                  await collRef.add({
                    'name': nameController.text,
                    'phone_no': phoneNoController.text,
                    'email_id': emailController.text,
                    'aadhar_no': aadhaarController.text,
                    'address': addressController.text,
                  });
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FixNowApp()),
                  );
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


                  // Navigate to ServHandyman page after data is saved







