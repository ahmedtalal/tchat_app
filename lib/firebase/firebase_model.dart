import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseModel {
  dynamic addData(var model);
  Stream<QuerySnapshot> retrieveAllData(var model);
  Stream<DocumentSnapshot> getSpecificData(var model);
  dynamic updataData(var model);
  dynamic deleteData(var model);
  Map<String, dynamic> convertModelToMap(var model, String id);
  User getUser();
}
