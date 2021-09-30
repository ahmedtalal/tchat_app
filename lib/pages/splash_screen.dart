import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/pages/authentication/login.dart';
import 'package:tchat/pages/authentication/register.dart';
import 'package:tchat/widgets/slider_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Carousel(
                dotSize: 6.0,
                dotSpacing: 22.0,
                indicatorBgPadding: 5.0,
                dotBgColor: Colors.transparent,
                dotVerticalPadding: 25.0,
                dotIncreasedColor: Colors.blue,
                dotColor: Colors.grey,
                animationDuration: Duration(milliseconds: 800),
                images: [
                  SliderWidget(
                    image: image1,
                    title: title1,
                    description: description1,
                  ),
                  SliderWidget(
                    image: image2,
                    title: title2,
                    description: description2,
                  ),
                  SliderWidget(
                    image: image3,
                    title: title3,
                    description: description3,
                  ),
                  SliderWidget(
                    image: image4,
                    title: title4,
                    description: description4,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    height: height * 0.077,
                    width: width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => Register(),
                        ));
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 22.0,
                          fontFamily: YuseiMagic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: YuseiMagic,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2.0,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
