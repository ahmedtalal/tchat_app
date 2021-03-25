import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';

// ignore: must_be_immutable
class TextInputWidget extends StatelessWidget {
  String hint;
  IconData icon;
  Function onClick;
  TextInputWidget({
    @required this.hint,
    @required this.icon,
    @required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        prefixIcon: Icon(icon,color: Colors.black54,),
        labelStyle: TextStyle(
          fontFamily: YuseiMagic,
          color: Colors.black,
        ),
        filled: true,
        fillColor: Colors.lightBlue[100],
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
      ),
      obscureText: hint.toLowerCase() == "password" ? true : false,
      keyboardType: hint.toLowerCase() == "name"
          ? TextInputType.text
          : TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          return "this field is required";
        }
        return null;
      },
      onSaved: onClick,
    );
  }
}
