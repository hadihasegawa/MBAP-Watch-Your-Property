
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_watchyourproperty/models/history.dart';
import 'package:project_watchyourproperty/screens/updateScreen.dart';



import '../models/service.dart';
import '../services/firestore_service.dart';

class HistoryList extends StatefulWidget {


  @override
  State<HistoryList> createState() => _ServiceListState();
}

class _ServiceListState extends State<HistoryList> {
  FirestoreService fsService = FirestoreService();


  @override
  Widget build(BuildContext context) {


    return StreamBuilder<List<Myhistory>>(
        stream: fsService.getMyHistory(),
        builder: (context, snapshot) {
          return ListView.separated(
            itemBuilder: (ctx, i) {
              return ListTile(
                  leading:CircleAvatar(
                      backgroundColor: Color. fromARGB(0, 0, 0, 0),
                      child:

                      snapshot.data![i].serviceType == 'plumbing' ? Image.asset('images/plumbing.png') :
                      snapshot.data![i].serviceType == 'locksmith' ? Image.asset('images/locksmith.png'):
                      snapshot.data![i].serviceType == 'electrician' ? Image.asset('images/gloves.png'):
                      snapshot.data![i].serviceType == 'cleaning' ? Image.asset('images/cleaning.png'):
                      Image.asset('images/air-conditioning.png')
                  ),
                  title: Text(snapshot.data![i].description),
                  subtitle: Text(DateFormat('dd/MM/yyyy').format(snapshot.data![i].serviceDate)),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                      ],
                    ),
                  )
              );
            },

            itemCount: snapshot.data!.length,

            separatorBuilder: (ctx, i) {
              return Divider(height: 3, color: Colors.blueGrey,);
            },

          );
        }
    );
  }
}