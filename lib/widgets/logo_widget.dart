import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoWidget extends StatelessWidget {
  String image;
  LogoWidget({@required this.image});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height ;
    return Image(
      image: AssetImage(image),
      height: height* 0.2,
    );
  }
}
