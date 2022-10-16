
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_watchyourproperty/screens/updateScreen.dart';



import '../models/service.dart';
import '../services/firestore_service.dart';

class ServiceList extends StatefulWidget {


  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  FirestoreService fsService = FirestoreService();
  void removeItem (String id) {
    showDialog<Null>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to cancel?'),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    fsService.removeService(id);
                  });
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {


    return StreamBuilder<List<Servicing>>(
        stream: fsService.getServicemen(),
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
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                UpdateScreen.routeName,
                                arguments: snapshot.data![i]);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeItem(snapshot.data![i].id);
                          },
                        ),
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