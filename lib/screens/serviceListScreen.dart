import 'package:flutter/material.dart';
import 'package:project_watchyourproperty/screens/home.dart';
import 'package:project_watchyourproperty/widgets/app_drawer.dart';

import 'package:provider/provider.dart';


import '../services/firestore_service.dart';
import '../models/service.dart';
import '../widgets/service_list.dart';

class serviceListScreen extends StatefulWidget {
  static String routeName = '/list-service';

  @override
  State<serviceListScreen> createState() => _serviceListScreenState();
}

class _serviceListScreenState extends State<serviceListScreen> {
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<dynamic>>(
      stream: fsService.getServicemen(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator()) :
        Scaffold(

          body: Container(
              alignment: Alignment.center,
              child: snapshot.data!.length > 0 ? ServiceList() :
              Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset('images/empty.png', width: 300),
                  Text('No services yet, request one today!', style:
                  Theme.of(context).textTheme.subtitle1),
                ],
              )
          ),
        );
      }
    );
  }
}