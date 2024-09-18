import 'package:flutter/material.dart';
import 'handyman_bookings.dart';
import 'package:rename/rename.dart';
void main() => runApp(const FixNowApp());

class FixNowApp extends StatelessWidget {
  const FixNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double toolbarHeight = constraints.maxHeight * 0.1;
        double appBarFontSize = toolbarHeight*0.5;
        double iconSize = appBarFontSize*1.5;
        return MaterialApp(
      title: 'FixNow: Find, Hire, Fix!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: toolbarHeight,
          title: 
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/fixnow_light.png', fit: BoxFit.cover, height: iconSize, width: iconSize),
            Text(
            'FixNow!',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
              fontSize: appBarFontSize
            ),
          ) 
          ],), 
          backgroundColor: const Color.fromRGBO(100, 130, 173, 1),

        ),
        body: const Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[LoginForm()],
        )),
      ),
    );
      }
      );
    
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = true;
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
          padding: EdgeInsets.all(constraints.maxWidth * 0.05), // Responsive padding
          child: Center(
            child: SizedBox(
              width: formWidth,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.05), // Responsive spacing
                    TextFormField(
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.black,),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.05), // Responsive spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to a new sign-up page or perform an action
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
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context)=>const HomePage())
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=> const Notifications())
                          );
                        // }else{
                          // return 'Please check credentials!';
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(buttonWidth, 50), // Full-width button within the form width
                        backgroundColor: const Color.fromRGBO(226, 241, 255, 0.643),
                        
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color.fromRGBO(100, 130, 173, 10),
                          fontWeight: FontWeight.w700
                        ),),
                    ),
                    )
                    
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
