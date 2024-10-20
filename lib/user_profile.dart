import 'dart:io'; // For File type
import 'package:FixNow/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking an image

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

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

  File? _image; // To hold the selected image
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from gallery
//   Future<void> _pickImage() async {
//   final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

//   if (pickedImage != null) {
//     setState(() {
//       _image = File(pickedImage.path); // Update the image file state
//     });
//   }
// }
Future<void> _pickImage() async {
  final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      _image = File(pickedImage.path); // Update the image file state
    });
  }
}



  // Function to upload image to Firebase Storage and return the URL
  Future<String?> _uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('user_profiles/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
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
            color: Color(0xFFEBF4F6), // Text color EBF4F6
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF071952), // Background color #071952
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              // Circle Avatar for profile image with plus icon
              Stack(
                children: [
                  // CircleAvatar(
                  //   radius: 60,
                  //   backgroundColor: Colors.grey[200], // Provide a background color in case no image is selected
                  //   backgroundImage: _image != null ? FileImage(_image!) : null, // Check if image is not null
                  //   child: _image == null
                  //       ? const Icon(Icons.person, size: 60, color: Colors.grey) // Display default icon if no image is selected
                  //       : null, // If an image is selected, don't show the icon
                  // ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.person, size: 60, color: Colors.grey) 
                        : null, // Icon should not show if an image is selected
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.add_circle, color: Color(0xFF37B7C3), size: 30),
                      onPressed: _pickImage,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Input for name
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
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
                  // Upload image and get download URL
                  String? imageUrl;
                  if (_image != null) {
                    imageUrl = await _uploadImage(_image!);
                  }

                  // Save other details along with image URL to Firestore
                  CollectionReference collRef = FirebaseFirestore.instance.collection('user_profile');
                  
                  await collRef.add({
                    'name': nameController.text,
                    'phone_no': phoneNoController.text,
                    'email_id': emailController.text,
                    'aadhar_no': aadhaarController.text,
                    'address': addressController.text,
                    'profile_image': imageUrl ?? 'No image uploaded',
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
