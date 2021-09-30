import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/firebase/firebase_model.dart';
import 'package:tchat/models/post_model.dart';

class PostCrudServices implements FirebaseModel {
  static PostCrudServices _postServices;

// this method is used to create only one instance fom this class >>>>>
  static PostCrudServices getInstance() {
    if (_postServices == null) {
      return _postServices = PostCrudServices();
    }
    return _postServices;
  }

  String generateID(String id) {
    return id;
  }

  @override
  Future<bool> addData(model) async {
    bool result = false;
    PostModel post = model as PostModel;
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Posts");
    DocumentReference docRef = collRef.doc(post.postId);
    Map<String, dynamic> data = convertModelToMap(post, post.postId);
    await docRef.set(data).whenComplete(() {
      result = true;
    }).catchError(
        (onError) => print("the add post operation has error $onError"));
    return result;
  }

  @override
  Map<String, dynamic> convertModelToMap(model, String id) {
    return model.toMap();
  }

  @override
  deleteData(model) async {
    bool result = false;
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Posts");
    DocumentReference docRef = collRef.doc(model);
    await docRef.delete().whenComplete(() {
      result = true;
    }).catchError(
        (onError) => print("error in deleting post process $onError"));
    return result;
  }

  @override
  User getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Stream<QuerySnapshot> retrieveAllData(var model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    CollectionReference collRef = store.collection("Posts");
    return collRef.snapshots();
  }

  @override
  updataData(model) async {
    bool result = false;
    PostModel postModel = model as PostModel;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("Posts").doc(postModel.postId);
    Map<String, dynamic> data = convertModelToMap(model, "id");
    await docRef.update(data).whenComplete(() {
      result = true;
      print(result);
    }).catchError(
        (onError) => print("error in updating post process $onError"));
    return result;
  }

  @override
  Stream<DocumentSnapshot> getSpecificData(model) {
    FirebaseFirestore store = FirebaseFirestore.instance;
    DocumentReference docRef = store.collection("Posts").doc(model);
    return docRef.snapshots();
  }
}
