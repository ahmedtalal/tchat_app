import 'package:firebase_auth/firebase_auth.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/models/user_model.dart';

class AuthServices {
  static AuthServices _authServics;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // this method is used to create only one instance form authservices class >>>>
  static AuthServices getInstance() {
    if (_authServics == null) {
      return _authServics = AuthServices();
    }
    return _authServics;
  }

  register(UserModel user) async {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    if (credential != null) {
      String id = FirebaseAuth.instance.currentUser.uid;
      UserModel userModel = UserModel.all(id, user.name, user.email, "null");
      return await AuthCrudServices.getInstance().addData(userModel);
    }
    return false;
  }

  login(UserModel model) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: model.email, password: model.password);
    if (credential != null) {
      return true;
    }
    return false;
  }

  Stream<User> checkCurrentUser() {
    // User user = _auth.currentUser;
    // if (user != null) {
    //   IdTokenResult idTokenResult = await user.getIdTokenResult(true);
    //   return idTokenResult.token != null;
    // }
    // return false;
    return _auth.authStateChanges();
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
