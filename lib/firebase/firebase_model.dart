import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseModel {
  Future<bool> addData(var model) ;
  Stream<QuerySnapshot> retrieveAllData(var model) ;
  Stream<DocumentSnapshot> getSpecificData(var model);
  bool updataData(var model) ;
  bool deleteData(var model) ;
  Map<String,dynamic> convertModelToMap(var model,String id) ;
  User getUser();
}