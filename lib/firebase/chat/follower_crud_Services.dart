import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/firebase/firebase_model.dart';

class FollowerCrudServices implements FirebaseModel {
  static FollowerCrudServices _followCrudServices;

  static FollowerCrudServices getInstance() {
    if (_followCrudServices == null) {
      return _followCrudServices = FollowerCrudServices();
    }
    return _followCrudServices;
  }

  @override
  Future<bool> addData(model) async{
    bool result = false;
    Map<String, dynamic> data = {"id":getUser().uid};
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Follower");
    DocumentReference docRef =collRef.doc(model).collection("users").doc(getUser().uid);
    await docRef.set(data).whenComplete(() {
      result = true;
    }).catchError(
        (onError) => print("the add follower operation has error $onError"));
    return result;
  }

  @override
  Map<String, dynamic> convertModelToMap(model, String id) {
    return model.followToMap();
  }

  @override
  bool deleteData(model) {
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot> getSpecificData(model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Follower");
    DocumentReference docRef = collRef.doc(model).collection("users").doc(model);
    return docRef.snapshots();
  }

  @override
  User getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Stream<QuerySnapshot> retrieveAllData(var model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Follower").doc(model).collection("users");
    return collRef.snapshots();
  }

  @override
  bool updataData(model) {
    throw UnimplementedError();
  }
}
