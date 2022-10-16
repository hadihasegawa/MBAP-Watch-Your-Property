

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../services/firestore_service.dart';

class ServicePage extends StatefulWidget {

  static String routeName = '/addservice';

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  var form = GlobalKey<FormState>();

  String? description;
  String? serviceType;
  DateTime? serviceDate;



  void saveForm() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      if (serviceDate == null) serviceDate = DateTime.now();
      print(description);
      print(serviceType);


      FirestoreService fsService = FirestoreService();
      fsService.addHistory(description, serviceType, serviceDate);
      fsService.addService(description, serviceType, serviceDate);


      // Hide the keyboard
      FocusScope.of(context).unfocus();
      // Resets the form
      form.currentState!.reset();
      serviceDate = null;
      // Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Service added successfully!'),));
    }
  }
  void presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Background
              onPrimary: Colors.white, // Text
              onSurface: Colors.blue, // Numbering
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) return;
      setState(() {
        serviceDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: Column(
        children: [
          Image.asset('images/logo.png', width: 150),
          Container(


            padding: EdgeInsets.all(10),
            child:
            Form(
              key: form,
              child: Column(

                children: [
                  SizedBox(height:5),

                  DropdownButtonFormField(

                    decoration: InputDecoration(
                      icon: Icon(Icons.home_repair_service),

                      label: Text('Choose a Service'),
                    ),

                    items: [
                      DropdownMenuItem(child: Text('Plumbing'), value: 'plumbing'),
                      DropdownMenuItem(child: Text('Locksmiths'), value: 'locksmith'),
                      DropdownMenuItem(child: Text('Electrician'), value: 'electrician'),
                      DropdownMenuItem(child: Text('Cleaning'), value: 'cleaning'),
                      DropdownMenuItem(child: Text('Aircondition'), value: 'aircondition'),
                    ],
                    validator: (value) {
                      if (value == null)
                        return "Please select a service.";
                      else
                        return null;
                    }, //to validate if input by user is correct
                    onChanged: (value) {
                      serviceType = value as String;
                    }, //to save the state
                  ),
                  SizedBox(height:20),
                  TextFormField(
                    decoration: InputDecoration(

                      label: Text('Description of Issue'),
                      icon: Icon(Icons.description),

                    ),
                    onSaved: (value) {
                      description = value!;
                    },
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(serviceDate == null ? 'No Date Chosen': "Picked date: " +
                            DateFormat('dd/MM/yyyy').format(serviceDate!)),

                        TextButton(
                            child: Text('Choose Date',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            onPressed: () { presentDatePicker(context); })
                      ],
                    ),
                  ),

                  SizedBox(height:20),
                  Material(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      hoverColor: Colors.orange,
                      splashColor: Colors.red,
                      focusColor: Colors.yellow,
                      highlightColor: Colors.purple,
                      onTap: () { saveForm(); },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Request Now', style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),



                ],

              ),
            ),

          ),
        ],
      ),
    );
  }
}
