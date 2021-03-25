import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/firebase/firebase_model.dart';

class FollowCrudServices implements FirebaseModel {
  static FollowCrudServices _followCrudServices;

  static FollowCrudServices getInstance() {
    if (_followCrudServices == null) {
      return _followCrudServices = FollowCrudServices();
    }
    return _followCrudServices;
  }

  @override
  Future<bool> addData(model) async{
    bool result = false;
    Map<String, dynamic> data = {"id":model};
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Following");
    DocumentReference docRef =collRef.doc(getUser().uid).collection("users").doc(model);
    await docRef.set(data).whenComplete((){
      result =true;
    }).catchError(
        (onError) => print("the add following operation has error $onError"));
    return result;
  }

  @override
  Map<String, dynamic> convertModelToMap(model, String id) {
    return model.followToMap();
  }

  @override
  bool deleteData(model) {
    var result = false ;
    FirebaseFirestore store = FirebaseFirestore.instance ;
    CollectionReference collRef = store.collection("Following");
    DocumentReference docRef = collRef.doc(getUser().uid).collection("users").doc(model);
    docRef.delete().whenComplete((){
      result = true ;
    }).catchError((onError)=>print("the error is $onError"));
    return result;
  }

  @override
  Stream<DocumentSnapshot> getSpecificData(model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Following");
    DocumentReference docRef = collRef.doc(getUser().uid).collection("users").doc(model);
    return docRef.snapshots();
  }

  @override
  User getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Stream<QuerySnapshot> retrieveAllData(var model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Following").doc(model).collection("users");
    return collRef.snapshots();
  }

  @override
  bool updataData(model) {
    throw UnimplementedError();
  }
}
