import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  Function onClick ;
  String hint ;
  var heightValue ;
  SearchWidget({@required this.onClick,@required this.heightValue,@required this.hint});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightValue,
      child: TextField(
        maxLines: hint != "Search" ? 10: 1,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(
            fontFamily: YuseiMagic,
            color: Colors.black,
          ),
          prefixIcon: hint == "Search" ? Icon(Icons.search): null,
          filled: true,
          fillColor: Colors.lightBlue[100],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        onChanged: onClick,
      ),
    );
  }
}
