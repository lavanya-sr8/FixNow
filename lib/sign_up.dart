import 'package:FixNow/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double toolbarHeight = constraints.maxHeight * 0.1;
        double appBarFontSize = toolbarHeight * 0.5;
        double iconSize = appBarFontSize * 1.5;
        return MaterialApp(
          title: 'FixNow: Find, Hire, Fix!',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(
              toolbarHeight: toolbarHeight,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/fixnow_dark.png',
                    fit: BoxFit.cover,
                    height: iconSize,
                    width: iconSize,
                  ),
                  Text(
                    'FixNow!',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: appBarFontSize,
                    ),
                  ),
                ],
              ),
              backgroundColor: const Color(0xFF2C3333),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Container(
              color: const Color(0xFFE7F6F2),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[SignUpForm()],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool obscureText = true;
  bool obscureTextConfirm = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widthFactor;
        double buttonWidth = constraints.maxWidth * 0.5;
        if (constraints.maxWidth <= 800) {
          widthFactor = 1.0;
        } else {
          widthFactor = 0.5;
        }

        final double formWidth = constraints.maxWidth * widthFactor;

        return Container(
          padding: EdgeInsets.all(constraints.maxWidth * 0.05),
          child: Center(
            child: SizedBox(
              width: formWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Username TextField
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),

                    // Email TextField
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Enter E-mail',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),

                    // Password TextField
                    TextFormField(
                      controller: _passwordController,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),

                    // Confirm Password TextField
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: obscureTextConfirm,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        hintText: 'Confirm password',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureTextConfirm
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureTextConfirm = !obscureTextConfirm;
                            });
                          },
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),

                    // Sign Up Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await signUp(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                                context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth, 50),
                          backgroundColor:
                              const Color.fromRGBO(226, 241, 255, 0.643),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF395B64),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Sign up function to register the user with Firebase and store username
  Future<void> signUp(String username, String email, String password,
      BuildContext context) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Get the user's ID
      String uid = userCredential.user!.uid;

      // Store username in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'uid': uid,
      });

      // Navigate to the UserProfile page with username and email autofilled
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserProfile(username: username, email: email)),
      );
    } catch (e) {
      // Handle sign-up errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: ${e.toString()}')),
      );
    }
  }
}
