import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tchat/firebase/firebase_model.dart';

class ChatOperations extends FirebaseModel {
  CollectionReference _collRef =
      FirebaseFirestore.instance.collection("ChatRooms");
  @override
  addData(model) async {
    bool result = false;
    DocumentReference docRef = _collRef
        .doc(model.currentUserId)
        .collection("users")
        .doc(model.reciverId)
        .collection("MessageList")
        .doc(model.docId);
    await docRef.set(model).whenComplete(() {
      result = true;
    });
    return result;
  }

  @override
  Map<String, dynamic> convertModelToMap(model, String id) {
    // TODO: implement convertModelToMap
    throw UnimplementedError();
  }

  @override
  deleteData(model) {
    // TODO: implement deleteData
    throw UnimplementedError();
  }

  @override
  Stream<DocumentSnapshot> getSpecificData(model) {
    // TODO: implement getSpecificData
    throw UnimplementedError();
  }

  @override
  User getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot> retrieveAllData(model) {
    // TODO: implement retrieveAllData
    throw UnimplementedError();
  }

  @override
  updataData(model) {
    // TODO: implement updataData
    throw UnimplementedError();
  }
}
