import 'package:flutter/material.dart';

import '../services/auth_service.dart';


class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? email;
  String? password;
  bool isObscurePassword = true;
  bool isPasswordTextField = true;
  var form = GlobalKey<FormState>();
  login() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      AuthService authService = AuthService();
      return authService.login(email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successfully!'),
        ));
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Email Address',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text('Email'),

              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null)
                  return "Please provide an email address.";
                else if (!value.contains('@'))
                  return "Please provide a valid email address.";
                else
                  return null;
              },
              onSaved: (value) {
                email = value;
              },
            ),
          ),
          SizedBox(height: 5),
          Text('Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText:
              isPasswordTextField ? isObscurePassword : false,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: isPasswordTextField
                    ? IconButton(
                    icon: Icon(Icons.remove_red_eye_rounded,
                        color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });


                    }):null,
                filled: true,
                fillColor: Colors.white,
                label: Text('Password'),

              ),
              validator: (value) {
                if (value == null)
                  return 'Please provide a password.';
                else if (value.length < 6)
                  return 'Password must be at least 6 characters.';
                else
                  return null;
              },
              onSaved: (value) {
                password = value;
              },
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(right: 40, left:40 ),
            child: ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(
                  )
              ),
            ),
          ),
          SizedBox(height: 10),
          // Padding(
          //     padding: const EdgeInsets.only(right: 15, left:15 ),
          //     child: ElevatedButton.icon(
          //       style: ElevatedButton.styleFrom(
          //         primary: Colors.white,
          //         onPrimary: Colors.black,
          //       )
          //       ,onPressed: () {
          //       final provider = Provider.of<GoogleSignInProvider>(context, listen:false);provider.googleLogin();},
          //       label: Text('Sign Up with Google'),
          //       icon: FaIcon(FontAwesomeIcons.google,color: Colors.greenAccent,),
          //     )
          // ),
        ],
      ),
    );
  }
}
