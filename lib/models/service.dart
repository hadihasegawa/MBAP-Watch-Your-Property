import 'package:cloud_firestore/cloud_firestore.dart';

class Servicing{
  String id;
  String description;
  String serviceType;
  DateTime serviceDate;

  Servicing({ required this.id, required this.description, required this.serviceType,
    required this.serviceDate});

  Servicing.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        description = snapshot['description'] ?? '',
        serviceType = snapshot['serviceType'] ?? '',
        serviceDate = (snapshot['serviceDate'] ?? Timestamp.now() as
        Timestamp).toDate();
}
