import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:multi_select_flutter/multi_select_flutter.dart'; // Multi-select import

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
  
  List<String> _selectedServices = [];

  final List<String> _services = [
    "Plumbing",
    "Electrical",
    "Carpentry",
    "Painting",
    "Cleaning",
  ];

  // Function to handle Firestore data submission
  // Future<void> _registerHandyman() async {
  //   if (_formKey.currentState!.validate()) {
  //     // Firestore collection reference
  //     CollectionReference handymanProfile = FirebaseFirestore.instance.collection('handy_profile');

  //     // Add data to Firestore
  //     await handymanProfile.add({
  //       'name': _nameController.text,
  //       'address': _addressController.text,
  //       'qualification': _qualificationController.text,
  //       'services': _selectedServices,  // Add selected services
  //     });

  //     // Show success message or navigate to another page
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Handyman registered successfully!')),
  //     );

  //     // Clear the form fields after successful registration
  //     _nameController.clear();
  //     _addressController.clear();
  //     _qualificationController.clear();
  //     setState(() {
  //       _selectedServices = [];
  //     });
  //   }
  // }

  Future<void> _registerHandyman() async {
  if (_formKey.currentState!.validate()) {
    // Get the current user's UID
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      // Get the user's profile from Firestore
      DocumentSnapshot userProfile = await FirebaseFirestore.instance.collection('user_profile').doc(uid).get();

      // Check if the user is already a handyman
      if (userProfile.exists && userProfile['isHandyman'] == true) {
        // Show an error message if the user is already registered as a handyman
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are already registered as a handyman!')),
        );
      } else {
        // Proceed with handyman registration
        CollectionReference handymanProfile = FirebaseFirestore.instance.collection('handy_profile');

        await handymanProfile.add({
          'name': _nameController.text,
          'address': _addressController.text,
          'services': _selectedServices,
          'uid': uid, // Link handyman profile with user
        });

        // Update the 'isHandyman' field in the user profile
        await FirebaseFirestore.instance.collection('user_profile').doc(uid).update({
          'isHandyman': true,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Handyman registered successfully!')),
        );

        // Clear the form fields after successful registration
        _nameController.clear();
        _addressController.clear();
        _qualificationController.clear();
        setState(() {
          _selectedServices = [];
        });
      }
    } else {
      // Show an error if the user is not logged in
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to register as a handyman.')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handyman Registration'),
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
            child: Form( 
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  TextFormField(
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
                  const SizedBox(height: 20),
                  // Multi-Select Dropdown
                  MultiSelectDialogField(
                    items: _services.map((e) => MultiSelectItem(e, e)).toList(),
                    title: const Text("Qualifications"),
                    selectedColor: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    buttonIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.blue,
                    ),
                    buttonText: const Text(
                      "Select Services",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    onConfirm: (results) {
                      setState(() {
                        _selectedServices = results.cast<String>();
                      });
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: _registerHandyman,
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




