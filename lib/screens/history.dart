import 'package:flutter/material.dart';
import 'package:project_watchyourproperty/screens/home.dart';
import 'package:project_watchyourproperty/widgets/app_drawer.dart';
import 'package:project_watchyourproperty/widgets/history_list.dart';

import 'package:provider/provider.dart';


import '../services/firestore_service.dart';
import '../models/service.dart';
import '../widgets/service_list.dart';

class HistoryScreen extends StatefulWidget {
  static String routeName = '/history';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    FirestoreService fsService = FirestoreService();

    return StreamBuilder<List<dynamic>>(
        stream: fsService.getMyHistory(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()) :
          Scaffold(

            body: Container(
                alignment: Alignment.center,
                child: snapshot.data!.length > 0 ? HistoryList() :
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
