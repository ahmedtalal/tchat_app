import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/widgets/button_widget.dart';

class RateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20.0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Rate App",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: YuseiMagic,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Please do not forget rate our app because it will help us to improve the app.",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: YuseiMagic,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.08,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) {
                    return Icon(
                      index < 3 ? Icons.star : Icons.star_border,
                      size: 35.0,
                      color: index < 3 ? Colors.blue : null,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.09,
            ),
            ButtonWidget(
              hint: "Go Now",
              height: height * 0.077,
              width: width * 0.85,
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
