import 'package:FixNow/handyman_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _experienceController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<String> _selectedServices = [];
  List<String> _selectedLocalities = [];
  
  final List<String> _services = [
    "Plumbing",
    "Electrical",
    "Carpentry",
    "Painting",
    "Cleaning",
  ];
  
  final List<String> _localities = [
    'Gandhipuram',
    'R S Puram',
    'Peelamedu',
    'Singanallur',
    'Saibaba Colony',
    'Ukkadam',
    'Sivananda Colony',
    'Vadavalli',
    'Sulur',
    'Thudiyalur',
    'Karamadai',
    'Ramanathapuram',
    'Sundarapuram',
    'Kovaipudur',
    'Podanur',
    'Perur',
    'Town Hall',
    'Race Course',
    'Saravanampatti'
  ];

  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    _getFCMToken();
  }

  Future<void> _getFCMToken() async {
    _fcmToken = await _firebaseMessaging.getToken();
  }

  Future<void> _registerHandyman() async {
    if (_formKey.currentState!.validate()) {
      CollectionReference handymanProfile = FirebaseFirestore.instance.collection('handy_profile');

      DocumentReference handymanDocRef = await handymanProfile.add({
        'name': _nameController.text,
        'address': _addressController.text,
        'qualification': _qualificationController.text,
        'experience': _experienceController.text,
        'services': _selectedServices,
        'preferredLocalities': _selectedLocalities,  // Store selected localities
        'fcmToken': _fcmToken,
      });

      String handymanId = handymanDocRef.id;
      await handymanDocRef.update({'handymanId': handymanId});

      String clientId = FirebaseAuth.instance.currentUser?.uid ?? '';
      if (clientId.isNotEmpty) {
        await FirebaseFirestore.instance.collection('Users').doc(clientId).update({
          'handymanId': handymanId,
        });
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isHandymanRegistered', true);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Handyman registered successfully!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HandymanDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Handyman Registration'),
        backgroundColor: const Color(0xFF2C3333),
      ),
      body: Container(
        color: const Color(0xFFE7F6F2),
        child: Padding(
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
                      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
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
                      validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
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
                      validator: (value) => value!.isEmpty ? 'Please enter your qualification' : null,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(
                        labelText: 'Experience',
                        hintText: 'Enter your experience in years',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter your experience' : null,
                    ),
                    const SizedBox(height: 16.0),
                    MultiSelectDialogField(
                      items: _services.map((e) => MultiSelectItem(e, e)).toList(),
                      title: const Text("Services"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      buttonText: const Text(
                        "Select Services",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedServices = results.cast<String>();
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    MultiSelectDialogField(
                      items: _localities.map((e) => MultiSelectItem(e, e)).toList(),
                      title: const Text("Preferred Localities"),
                      selectedColor: Colors.blue,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      buttonText: const Text(
                        "Select Preferred Localities",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onConfirm: (results) {
                        setState(() {
                          _selectedLocalities = results.cast<String>();
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: _registerHandyman,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF395B64),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFF2C3333),
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
