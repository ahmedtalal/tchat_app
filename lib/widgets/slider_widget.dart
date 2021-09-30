import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/providers/darkmode_provider.dart';

// ignore: must_be_immutable
class SliderWidget extends StatelessWidget {
  String image, title, description;
  SliderWidget({
    @required this.image,
    @required this.title,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Consumer<DarkThemeNotifier>(
      builder: (context, DarkThemeNotifier notifier, child) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Image(
                  image: AssetImage(image),
                  height: height * 0.4,
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  width: width * 0.8,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 23.0,
                      fontFamily: YuseiMagic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: width * 0.8,
                  child: Center(
                    child: Text(
                      description,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: YuseiMagic,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
