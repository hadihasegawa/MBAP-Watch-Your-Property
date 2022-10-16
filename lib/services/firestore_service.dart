import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_watchyourproperty/models/service.dart';

import '../models/history.dart';
import '../models/service.dart';
import 'auth_service.dart';

class FirestoreService{
  AuthService authService = AuthService();

  addService(description, serviceType, serviceDate) {
    return FirebaseFirestore.instance
        .collection('services')
        .add({'email': authService.getCurrentUser()!.email,
      'description': description, 'serviceType': serviceType, 'serviceDate': serviceDate});
  }
  removeService(id) {
    return FirebaseFirestore.instance
        .collection('services')
        .doc(id)
        .delete();
  }
  Stream<List<Servicing>> getServicemen(){
    return FirebaseFirestore.instance
        .collection('services')
        .snapshots()
        .map((snapshot)=> snapshot.docs
        .map<Servicing>((doc)=>Servicing.fromMap(doc.data(),doc.id))
        .toList());
  }
  updateServices(id,description, serviceType, serviceDate) {
    return FirebaseFirestore.instance
        .collection('services')
        .doc(id)
        .update({'description': description, 'serviceType': serviceType, 'serviceDate': serviceDate});
  }
  addHistory(description, serviceType, serviceDate) {
    return FirebaseFirestore.instance
        .collection('history')
        .add({'email': authService.getCurrentUser()!.email,
      'description': description, 'serviceType': serviceType, 'serviceDate': serviceDate});
  }
  Stream<List<Myhistory>> getMyHistory(){
    return FirebaseFirestore.instance
        .collection('history')
        .snapshots()
        .map((snapshot)=> snapshot.docs
        .map<Myhistory>((doc)=>Myhistory.fromMap(doc.data(),doc.id))
        .toList());
  }
}