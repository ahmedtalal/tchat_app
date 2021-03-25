import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/models/user_model.dart';
import '../firebase_model.dart';

class AuthCrudServices implements FirebaseModel {
  static AuthCrudServices _authCrudServices;

  static AuthCrudServices getInstance() {
    if (_authCrudServices == null) {
      return _authCrudServices = AuthCrudServices();
    }
    return _authCrudServices;
  }

  @override
  Future<bool> addData(model) async {
    bool result = false;
    UserModel userModel = model as UserModel;
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Users");
    DocumentReference docRef = collRef.doc(userModel.id);
    Map<String, dynamic> data = convertModelToMap(userModel, userModel.id);
    await docRef.set(data).whenComplete(() {
      result = true;
    }).catchError(
        (onError) => print("the add user operation has error $onError"));
    return result;
  }

  @override
  Map<String, dynamic> convertModelToMap(model, String id) {
    return model.toMap();
  }

  @override
  bool deleteData(model) {
    throw UnimplementedError();
  }

  @override
  User getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Stream<QuerySnapshot> retrieveAllData(var model) {
    CollectionReference collRef = FirebaseFirestore.instance.collection("Users");
    return collRef.snapshots();
  }

  @override
  bool updataData(model) {
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot> getSpecificData(model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    DocumentReference docRef = store.collection("Users").doc(model);
    return docRef.snapshots();
  }
}
