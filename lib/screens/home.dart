import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_watchyourproperty/services/firestore_service.dart';

import 'package:provider/provider.dart';
class FormScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  var form = GlobalKey<FormState>();
  String? description;
  String? serviceType;
  Icon? serviceIcon;
  DateTime? serviceDate;

  void saveForm () {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      if (serviceDate == null) serviceDate = DateTime.now();

      print(description);
      print(serviceType);

      FirestoreService fsService = FirestoreService();
      fsService.addService(description, serviceType, serviceDate);

      // Hide the keyboard
      FocusScope.of(context).unfocus();
// Resets the form
      form.currentState!.reset();
      serviceDate = null;
// Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Service successfully requested!'),));
    }
  }

  void presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
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
       body: SingleChildScrollView(
         child: Container(

          padding: EdgeInsets.all(10),

          child: Form(
            key: form,
          child: Column(
          children: [
            Image.asset('images/logo.png', width: 100),
            DropdownButtonFormField(
              decoration: InputDecoration(
                label: Text('Choice of Service'),
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
                  return "Please choose a service.";
                else
                  return null;
              },
              onChanged: (value) {serviceType = value as String;},
            ),

            TextFormField(
              decoration: InputDecoration(label: Text('Description')),
              validator: (value) {
                if (value == null)
                  return 'Please provide a description.';
                else if (value.length < 10)
                  return 'Please enter a description that is at least 10 characters long.';
                else
                  return null;
              },
              onSaved: (value) {description = value;},
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(serviceDate == null ? 'No Date Chosen': "Picked date: " +
                    DateFormat('dd/MM/yyyy').format(serviceDate!)
                ),
                TextButton(
                    child: Text('Choose Date', style: TextStyle(fontWeight:
                    FontWeight.bold)),
                    onPressed: () { presentDatePicker(context); }
                    ),
                  ]
                )
              ],
            ),
          ),
      ),
       ),
    );
  }
}
