import 'package:flutter/material.dart';
import 'package:project_watchyourproperty/screens/loginform.dart';
import 'package:project_watchyourproperty/screens/registerform.dart';
import 'package:project_watchyourproperty/screens/resetPassword.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import '../services/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  int currentIndex = 0;
  AuthService authService = AuthService();
  bool loginScreen = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 15),
                    Image.asset('images/logo.png', width: 150),
                    SizedBox(height: 5),
                    Text('Watch Your Property', textAlign: TextAlign.center,  style: TextStyle(fontSize: 30, color: Colors.blue)
                    ),
                    SizedBox(height: 5),



                  ],
                ),
                loginScreen ? LoginForm() : RegisterForm(),
                SizedBox(height: 5),
                loginScreen ? TextButton(onPressed: () {
                  setState(() {
                    loginScreen = false;
                  });
                }, child: Text('No account? Sign up here!')) :
                TextButton(onPressed: () {
                  setState(() {
                    loginScreen = true;
                  });
                }, child: Text('Exisiting user? Login in here!')),
                loginScreen ? TextButton(onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ResetPasswordScreen(),
                    ),
                  );
                }, child: Text('Forgotten Password')) : Center(),
                Padding(
                    padding: const EdgeInsets.only(right: 15, left:15 ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      )
                      ,onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(context, listen:false);provider.googleLogin();},
                      label: Text('Sign Up with Google'),
                      icon: Image.asset('images/google.png', height: 25 , width:25 ,),
                    )
                ),
              ],

            )
        ),

      ),
    );
  }
}
