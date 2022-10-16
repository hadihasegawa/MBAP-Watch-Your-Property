import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project_watchyourproperty/models/service.dart';
import 'package:project_watchyourproperty/services/firestore_service.dart';
import 'package:provider/provider.dart';
class UpdateScreen extends StatefulWidget {
  static String routeName = '/update';

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var form = GlobalKey<FormState>();
  String? description;
  String? serviceType;
  DateTime? serviceDate;

  void saveForm (String id) {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      if (serviceDate == null) serviceDate = DateTime.now();

      print(description);
      print(serviceType);

      FirestoreService fsService = FirestoreService();
      fsService.updateServices(id, description, serviceType, serviceDate);

      // Hide the keyboard
      FocusScope.of(context).unfocus();
// Resets the form
      form.currentState!.reset();
      serviceDate = null;
// Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Service successfully requested!'),));
      Navigator.of(context).pop();
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
    Servicing selectedService = ModalRoute.of(context)?.settings.arguments as
    Servicing;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(

        padding: EdgeInsets.all(10),

        child: Form(
          key: form,
          child: Column(
            children: [
              Image.asset('images/logo.png', width: 200),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text('Choice of Service'),
                ),
                value: selectedService.serviceType,
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
                onChanged: (value) {
                  serviceType = value as String;
                },
                onSaved: (value) {
                  serviceType = value as String;
                },
              ),


              TextFormField(
    initialValue: selectedService.description,
                decoration: InputDecoration(
                    label: Text('Description')
                    ),

                validator: (value) {
                  if (value == null)
                    return 'Please provide a description.';
                  else if (value.length < 5)
                    return 'Please enter a description that is at least 10 characters long.';
                  else
                    return null;
                },
                onSaved: (value) {
                  description = value!;
                },
                onChanged: (value) {
                  description = value as String;
                },
              ),

    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(serviceDate == null ? 'No Date Chosen': "Picked date: " + DateFormat('dd/MM/yyyy').format(serviceDate!)),
    TextButton(
    child: Text('Choose Date', style: TextStyle(fontWeight:
    FontWeight.bold)),
    onPressed: () { presentDatePicker(context); } )
    ],
    ),
              Material(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                child: InkWell(
                  hoverColor: Colors.orange,
                  splashColor: Colors.red,
                  focusColor: Colors.yellow,
                  highlightColor: Colors.blue,
                  onTap: () {saveForm(selectedService.id);},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Update Request', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}