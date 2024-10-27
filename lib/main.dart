import 'package:FixNow/firebase_options.dart';
import 'package:FixNow/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'sign_up.dart';

// Initialize flutter_local_notifications plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Initialization settings for Android and iOS
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

const InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);

// Global variable to store userId from Firestore
String? simId;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize local notifications
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  runApp(const FixNowApp());
}

class FixNowApp extends StatelessWidget {
  const FixNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double toolbarHeight = constraints.maxHeight * 0.1;
      double appBarFontSize = toolbarHeight * 0.5;
      double iconSize = appBarFontSize * 1.5;
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FixNow: Find, Hire, Fix!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFE7F6F2), // Change page color
        ),
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: toolbarHeight,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: const Color(0xFF395B64), // Change icon color
                  child: Image.asset(
                    'assets/fixnow_dark.png',
                    fit: BoxFit.cover,
                    height: iconSize,
                    width: iconSize,
                  ),
                ),
                Text(
                  'FixNow!',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white, // Change text color to white
                    fontSize: appBarFontSize,
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF2C3333), // Change header color
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[LoginForm()],
            ),
          ),
        ),
      );
    });
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // State for password visibility

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          color: const Color.fromRGBO(240, 221, 169, 0.004),
          padding:
              EdgeInsets.all(constraints.maxWidth * 0.05), // Responsive padding
          child: Center(
            child: SizedBox(
              width: formWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: formWidth * 0.04,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height:
                            constraints.maxWidth * 0.05), // Responsive spacing
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter password',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: formWidth * 0.04,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                        height:
                            constraints.maxWidth * 0.05), // Responsive spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Color.fromRGBO(100, 130, 173, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await signIn(_emailController.text.trim(),
                                _passwordController.text.trim(), context);
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
                          'Login',
                          style: TextStyle(
                            color: Color.fromRGBO(100, 130, 173, 10),
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
}

Future<void> signIn(String email, String password, BuildContext context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Fetch userId from Firestore if email matches
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('home')
        .where('email_id', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      simId = querySnapshot.docs.first['userId'];
      print('simId retrieved: $simId');
    }

    // On success, navigate to the next page (e.g., bookings or dashboard)

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(userId: simId!),
      ),
    );
  } catch (e) {
    // Handle errors (e.g., wrong credentials or user not found)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to login: ${e.toString()}')),
    );
  }
}
