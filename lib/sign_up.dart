import 'package:FixNow/user_profile.dart';
import 'package:flutter/material.dart';
// import 'package:rename/rename.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
            Image.asset('assets/fixnow_dark.png', fit: BoxFit.cover, height: iconSize, width: iconSize),
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
          automaticallyImplyLeading: true, // Automatically adds back arrow
          leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the current page and go back
          },
        ),
        ),
        body: const Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[SignUpForm()],
        )),
      ),
    );
      }
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
  final TextEditingController pwd = TextEditingController();
  // final TextEditingController confirm_pwd = TextEditingController();

  bool obscureText = true;
  bool obscureTextConfirm = true;


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
                        labelText: 'Username',
                        hintText: 'Enter your username',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Enter E-mail',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter E-mail id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02), // Responsive spacing
                    TextFormField(
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                    SizedBox(height: constraints.maxWidth * 0.02), // Responsive spacing
                    TextFormField(
                      obscureText: obscureTextConfirm,
                      decoration: InputDecoration(
                        labelText: 'Confirm password',
                        hintText: 'Confirm password',
                        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: formWidth * 0.04),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(obscureTextConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.black,),
                          onPressed: () {
                            setState(() {
                              obscureTextConfirm = !obscureTextConfirm;
                            });
                          },
                        )
                      ),
                      scrollPadding: const EdgeInsets.all(16.0),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password to confirm';
                        }else if(value != pwd.text){
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: constraints.maxWidth * 0.02),
                    Center(
                      child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>  const UserProfile())
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(buttonWidth, 50), // Full-width button within the form width
                        backgroundColor: const Color.fromRGBO(226, 241, 255, 0.643),
                        
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        )
                      ),
                      child: const Text(
                        'Sign Up',
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
