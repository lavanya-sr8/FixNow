import 'package:FixNow/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Global variable to store the userId
String? globalUserId;

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Controllers for each input field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixNow!',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFFEBF4F6),
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2C3333), // Header color changed
        toolbarHeight: 100,
      ),
      body: Container(
        color: const Color(0xFFE7F6F2), // Page color changed to E7F6F2
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Input for name
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your name',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF37B7C3),
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF37B7C3),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for phone number
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: phoneNoController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Enter your phone number',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF37B7C3),
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF37B7C3),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Please enter a valid 10-digit phone number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for email
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Enter your email ID',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF37B7C3),
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF37B7C3),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for Aadhaar number
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: aadhaarController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter your Aadhaar number',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF37B7C3),
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF37B7C3),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Aadhaar number';
                        } else {
                          String cleanedValue = value.replaceAll(' ', ''); // Remove spaces
                          if (cleanedValue.length != 12 || !RegExp(r'^[0-9]+$').hasMatch(cleanedValue)) {
                            return 'Please enter a valid 12-digit Aadhaar number';
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for address
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: addressController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Enter your address',
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF37B7C3),
                          ),
                        ),
                        floatingLabelStyle: TextStyle(
                          color: Color(0xFF37B7C3),
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 40),

                  // SAVE button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF37B7C3),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 70.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Save the data in Firestore
                        CollectionReference collRef = FirebaseFirestore.instance.collection('user_profile');
                        DocumentReference docRef = await collRef.add({
                          'name': nameController.text,
                          'phone_no': phoneNoController.text,
                          'email_id': emailController.text.toLowerCase(),
                          'aadhar_no': aadhaarController.text,
                          'address': addressController.text,
                        });

                        // Store userId in global variable
                        globalUserId = docRef.id;

                        // Navigate to HomePage without passing userId
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FixNowApp(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFEBF4F6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
