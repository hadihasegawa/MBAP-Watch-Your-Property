

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../screens/addService.dart';

import '../screens/history.dart';
import '../screens/serviceListScreen.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'app_drawer.dart';




  class NavBar extends StatefulWidget {
    static String routeName = '/nav';
    User currentUser;
    NavBar(this.currentUser);

    @override
    State<NavBar> createState() => _NavBarState();
  }
class _NavBarState extends State<NavBar>  {


  int currentIndex = 0;
  final screens = [
    ServicePage(),
    serviceListScreen(),
    HistoryScreen(),

  ];
  AuthService authService = AuthService();
  FirestoreService fsService = FirestoreService();
  logOut() {
    return authService.logOut().then((value) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout successfully!'),));
    }).catchError((error) {
      FocusScope.of(context).unfocus();
      String message = error.toString();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(message),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              logOut();
            },
            icon: Icon(Icons.logout_rounded)),

      ],),
      body: IndexedStack(index: currentIndex,
        children: screens,),
      drawer: AppDrawer(),
      backgroundColor: Colors.white,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Service List',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_sharp ),
            label: 'Service History',
            backgroundColor: Colors.blueAccent,
          ),
        ],

      ),

    );
  }
}

