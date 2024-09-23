import 'package:flutter/material.dart';
import 'package:FixNow/sign_up.dart';
import 'package:FixNow/user_profile.dart';


// import 'header.dart';
//import 'package:rename/rename.dart';


void main() => runApp(const FixNowApp());

// class FixNowApp extends StatelessWidget {
//   const FixNowApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FixNow: Find, Hire, Fix!',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: Header(showBackArrow: false), // Use the Header widget instead of AppBar
//         body: const Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               LoginForm(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff73a3f6),
              Color(0xff0a5578),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Insert the image here
            Image.asset('assets/images/fixnow_light.png'), // Replace 'fixnow_logo.png' with your actual image name
            SizedBox(height: 20),
            // Welcome message
            Text(
              'Welcome to FixNow!',
              style: TextStyle(
                color: Color(0xff1d0505),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 60),
            // Log In button
            TextButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FixNowApp()),
                        );

                // Navigate to Log In page
              },
              child: Text(
                'Log In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
        ),
        home: Scaffold(
          appBar: AppBar(
            toolbarHeight: toolbarHeight,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/fixnow_dark.png',
                    fit: BoxFit.cover, height: iconSize, width: iconSize),
                Text(
                  'FixNow!',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: appBarFontSize),
                )
              ],
            ),
            backgroundColor: const Color(0xFF071952),
          ),
          body: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[LoginForm()],
          )),
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
                      controller: _emailController, // Email controller added
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: formWidth * 0.04),
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
                      controller:
                          _passwordController, // Password controller added
                      obscureText:
                          !_isPasswordVisible, // Password visibility toggle added
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
                            _isPasswordVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible =
                                  !_isPasswordVisible; // Toggle password visibility
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
                                    builder: (context) => const SignUpPage()));
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>   UserProfile()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(buttonWidth,
                              50), // Full-width button within the form width
                         backgroundColor: const Color(0xFF00B4D8),

                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 0.965),
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
