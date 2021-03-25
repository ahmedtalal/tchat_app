import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_services.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/pages/bottom_navigationbar/nav_bar.dart';
import 'package:tchat/widgets/button_widget.dart';
import 'package:tchat/widgets/links_auth_widget.dart';
import 'package:tchat/widgets/logo_widget.dart';
import 'package:tchat/widgets/text_input_widget.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  String email, password;
  bool isProgress = false;
  var scafolldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scafolldKey,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.1,
                horizontal: width * 0.05,
              ),
              child: Column(
                children: [
                  LogoWidget(image: loginLogo),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: YuseiMagic,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextInputWidget(
                          hint: "email",
                          icon: Icons.email,
                          onClick: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextInputWidget(
                          hint: "password",
                          icon: Icons.lock,
                          onClick: (value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontFamily: YuseiMagic,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ButtonWidget(
                    hint: "Login",
                    height: height * 0.077,
                    width: width * 0.85,
                    onClick: () {
                      setState(() {
                        isProgress = !isProgress;
                      });
                      _validateLogin(context);
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  LinksWidget(title: "login", link: "login"),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateLogin(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      UserModel user = UserModel.emailpassword(email, password);
      try {
        var result = await AuthServices.getInstance().login(user);
        if (result == true) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NavBar(),
          ));
        } else {
          creareSnackbar("there is a problem in login");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "invalid-email") {
          creareSnackbar("email is invalid");
        }
        if (e.code == "wrong-password") {
          creareSnackbar("password is wrong");
        }
        if (e.code == "user-not-found") {
          creareSnackbar("this user in not found");
        }
      } catch (e) {
        creareSnackbar("the problem in ${e.toString()}");
      }
    } else {
      creareSnackbar("data is invalid");
    }
  }

  void creareSnackbar(String message) {
    setState(() {
      isProgress = !isProgress;
      scafolldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
