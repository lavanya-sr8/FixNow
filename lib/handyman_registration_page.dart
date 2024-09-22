import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''), // Remove the title from the AppBar
      ),
      body: Padding(
        padding: EdgeInsets.zero, // Remove padding around the Scaffold
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                _buildHeader(),
                const SizedBox(height: 20),
                // Form fields with top padding reduced
                Padding(
                  padding: const EdgeInsets.only(top: 0.0), // Adjust the top padding as needed
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)), // Sets border radius to zero for a rectangular input
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
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Handle registration logic here, e.g., send data to a server
                      print('Name: ${_nameController.text}');
                      print('Address: ${_addressController.text}');
                      print('Qualification: ${_qualificationController.text}');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 30, 209, 226), // Set the button color to #37B7C3
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
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF071952), // Header background color
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: const Center(
        child: Text(
          'FixNow!',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Header text color
          ),
        ),
      ),
    );
  }
}