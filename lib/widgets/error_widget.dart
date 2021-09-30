import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';

// ignore: must_be_immutable
class ErrorsWidget extends StatelessWidget {
  String type, hint;
  double height;
  ErrorsWidget(
      {@required this.hint, @required this.type, @required this.height});
  @override
  Widget build(BuildContext context) {
    if (this.type == "loading") {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: Container(
        height: this.height,
        child: Column(
          children: [
            Image(
              image: AssetImage(emptySearch),
              height: 150.0,
            ),
            Text(
              this.hint,
              style: TextStyle(
                fontFamily: YuseiMagic,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
