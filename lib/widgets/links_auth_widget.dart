import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/pages/authentication/login.dart';
import 'package:tchat/pages/authentication/register.dart';

// ignore: must_be_immutable
class LinksWidget extends StatelessWidget {
  String title, link;
  LinksWidget({@required this.title, @required this.link});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title.toLowerCase() == "login"
              ? "Do not have an account?"
              : "Already have an account?",
          style: TextStyle(
            fontSize: 15.0,
            fontFamily: YuseiMagic,
          ),
        ),
        InkWell(
          onTap: () {
            if (link.toLowerCase() == "login") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Register(),
              ));
            } else if (link.toLowerCase() == "register") {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              ));
            }
          },
          child: Text(
            title.toLowerCase() != "login" ? "Login" : "Register",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              fontFamily: YuseiMagic,
              color: Colors.blueGrey[600],
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
