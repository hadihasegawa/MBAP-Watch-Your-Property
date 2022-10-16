import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_watchyourproperty/screens/addService.dart';
import 'package:project_watchyourproperty/screens/addService.dart';
import 'package:project_watchyourproperty/screens/auth_screen.dart';

import 'package:project_watchyourproperty/screens/history.dart';
import 'package:project_watchyourproperty/screens/serviceListScreen.dart';
import 'package:project_watchyourproperty/services/auth_service.dart';
import 'package:project_watchyourproperty/services/google_sign_in.dart';
import 'package:project_watchyourproperty/widgets/app_drawer.dart';
import 'package:project_watchyourproperty/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';


import 'screens/home.dart';
import 'screens/updateScreen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ?  Center(child: CircularProgressIndicator())

          : StreamBuilder<User?>(
          stream: authService.getAuthUser(),
          builder: (context, snapshot) =>
            ChangeNotifierProvider(
              create: (context) => GoogleSignInProvider(),
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: snapshot.connectionState == ConnectionState.waiting ?
                Center(child: CircularProgressIndicator()) :
                snapshot.hasData ? NavBar(snapshot.data as User) : AuthScreen(),
                routes: {
                  NavBar.routeName : (_) { return NavBar(snapshot.data as User); },
                  serviceListScreen.routeName : (_) { return serviceListScreen(); },
                  HistoryScreen.routeName : (_) { return HistoryScreen(); },
                  UpdateScreen.routeName : (_) { return UpdateScreen(); },
                  ServicePage.routeName : (_) { return ServicePage(); },
                },

              ),
            )
          ),
    );
  }
}



class MainScreen extends StatefulWidget {



  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(


    );
  }
}
