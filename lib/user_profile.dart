import 'package:FixNow/ser_handyman.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
   const UserProfile({super.key});
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FixNow!',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color.fromARGB(255, 1, 1, 1),
            fontSize: 50.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF071952),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double formWidth = constraints.maxWidth;
              if (constraints.maxWidth <= 800) {
                formWidth = constraints.maxWidth;
              } else {
                formWidth = constraints.maxWidth * 0.5;
              }

              return Column(
                children: [
                  // Input for name
                  SizedBox(
                    width: formWidth,
                    child: TextField(
                      decoration: InputDecoration(
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for phone number
                  SizedBox(
                    width: formWidth,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for email
                  SizedBox(
                    width: formWidth,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for Aadhaar number
                  SizedBox(
                    width: formWidth,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Input for address
                  SizedBox(
                    width: formWidth,
                    child: TextField(
                      decoration: InputDecoration(
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
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // SAVE button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to ServHandyman page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ServHandyman()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF37B7C3),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 70.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFEBF4F6),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
