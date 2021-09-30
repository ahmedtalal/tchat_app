import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  var height, width;
  String hint;
  Function onClick;
  ButtonWidget({
    @required this.hint,
    @required this.height,
    @required this.width,
    @required this.onClick,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onClick,
        child: Text(
          hint,
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: YuseiMagic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
