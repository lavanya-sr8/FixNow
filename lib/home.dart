import 'package:FixNow/ser_handyman.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  final String userId;

  const HomePage({required this.userId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  bool isLoading = true;
  bool _showProfile = false;  // Toggle to show/hide the profile box
  bool _isEditing = false;    // Toggle between viewing and editing mode
  Map<String, dynamic>? _profileData;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user_profile')
          .doc(widget.userId)
          .get();

      if (userDoc.exists) {
        setState(() {
          _profileData = userDoc.data() as Map<String, dynamic>?;
          userName = _profileData?['name'];
          nameController.text = _profileData?['name'] ?? '';
          aadhaarController.text = _profileData?['aadhar_no'] ?? '';
          addressController.text = _profileData?['address'] ?? '';
          emailController.text = _profileData?['email_id'] ?? '';
          phoneController.text = _profileData?['phone_no'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          userName = "Guest";
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        userName = "Guest";
        isLoading = false;
      });
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      // Update Firestore with the new data
      await FirebaseFirestore.instance
          .collection('user_profile')
          .doc(widget.userId)
          .update({
        'name': nameController.text,
        'aadhar_no': aadhaarController.text,
        'address': addressController.text,  // Corrected this line
        'email_id': emailController.text,
        'phone_no': phoneController.text,
      });

      // Update the state to reflect the changes
      setState(() {
        userName = nameController.text;  // Update the welcome text with the new name
        _profileData = {
          'name': nameController.text,
          'aadhar_no': aadhaarController.text,
          'address': addressController.text,  // Corrected this line
          'email_id': emailController.text,
          'phone_no': phoneController.text,
        };
        _isEditing = false;  // Exit edit mode
      });
    } catch (e) {
      print("Error updating profile: $e");
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
            color: Color(0xFFEBF4F6),
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF071952),
        toolbarHeight: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // Toggle profile visibility
              setState(() {
                _showProfile = !_showProfile;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(  // Wrap the body with SingleChildScrollView to avoid overflow
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome, $userName!',
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF071952),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'FixNow is the perfect app to connect you with local handymen '
                        'and get your repairs done quickly and efficiently.'
                        'If you\'re a handyman, you can also connect with potential '
                        'clients through this platform.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF071952),
                        ),
                      ),
                      const SizedBox(height: 60),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF37B7C3),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 70.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {
                           Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ServHandyman(),
                        ),
                      );
                          // Handle Get Started button action
                        },
                        child: const Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFFEBF4F6),
                          ),
                        ),
                      ),

                      if (_showProfile && _profileData != null)
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _isEditing
                                ? _buildEditableFields()  // Show editable fields
                                : _buildProfileView(),  // Show profile data view
                          ),
                        ),
                      const SizedBox(height: 20),

                      if (_showProfile)
                        ElevatedButton(
                          onPressed: () {
                            if (_isEditing) {
                              _updateUserProfile();
                            } else {
                              setState(() {
                                _isEditing = true;
                              });
                            }
                          },
                          child: Text(_isEditing ? 'Save Changes' : 'Edit Profile'),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // Function to build profile view (non-editable)
  List<Widget> _buildProfileView() {
    return [
      _buildProfileField('Name', _profileData!['name']),
      const SizedBox(height: 10),
      _buildProfileField('Aadhaar Number', _profileData!['aadhar_no']),
      const SizedBox(height: 10),
      _buildProfileField('Address', _profileData!['address']),
      const SizedBox(height: 10),
      _buildProfileField('Email', _profileData!['email_id']),
      const SizedBox(height: 10),
      _buildProfileField('Phone Number', _profileData!['phone_no']),
    ];
  }

  // Function to build editable fields
  List<Widget> _buildEditableFields() {
    return [
      _buildEditableField('Name', nameController),
      const SizedBox(height: 10),
      _buildEditableField('Aadhaar Number', aadhaarController),
      const SizedBox(height: 10),
      _buildEditableField('Address', addressController),
      const SizedBox(height: 10),
      _buildEditableField('Email', emailController),
      const SizedBox(height: 10),
      _buildEditableField('Phone Number', phoneController),
    ];
  }

  // A helper widget to display profile field labels and values (non-editable)
  Widget _buildProfileField(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }

  // A helper widget to display editable text fields
  Widget _buildEditableField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter $label',
          ),
        ),
      ],
    );
  }
}

