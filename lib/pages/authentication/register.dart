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

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var formKey = GlobalKey<FormState>();
  var scafolldKey = GlobalKey<ScaffoldState>();

  String name, email, password;
  bool isProgress = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scafolldKey,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.09,
            horizontal: width * 0.05,
          ),
          child: ListView(
            children: [
              LogoWidget(image: registerLogo),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontFamily: YuseiMagic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
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
                      hint: "name",
                      icon: Icons.person,
                      onClick: (value) {
                        name = value;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
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
              SizedBox(
                height: height * 0.05,
              ),
              ButtonWidget(
                hint: "Register",
                height: height * 0.077,
                width: width * 0.85,
                onClick: () {
                  setState(() {
                    isProgress = !isProgress;
                  });
                  _validateRegister(context);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              LinksWidget(title: "register", link: "register"),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateRegister(BuildContext context) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      UserModel userModel = UserModel(name, email, password);
      try {
        var result = await AuthServices.getInstance().register(userModel);
        if (result == true) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => NavBar(),
          ));
        } else {
          creareSnackbar("there is a problem in registration");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-is-use") {
          creareSnackbar("email already is used");
        }
        if (e.code == "invalid-email") {
          creareSnackbar("email is invalid");
        }
        if (e.code == "weak-password") {
          creareSnackbar("this password is weak");
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
