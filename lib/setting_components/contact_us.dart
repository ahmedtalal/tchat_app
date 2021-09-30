import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: YuseiMagic,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "You can contact us from these links in below",
                  style: TextStyle(
                    fontFamily: YuseiMagic,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // facebook card ???????????????????????
              Expanded(
                flex: 2,
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(
                          "Facebook",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                        ),
                        onTap: () {
                          String url = "https://www.facebook.com/ahmd.talal.5";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    // instgram card ??????????????????????
                    Card(
                      child: ListTile(
                        title: Text(
                          "Instgram",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                        ),
                        onTap: () {
                          String url =
                              "https://www.instagram.com/ahmedtalal98/";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "LinkedIn",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                        ),
                        onTap: () {
                          String url =
                              "https://www.linkedin.com/in/ahmed-talal-211a47179/";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Github",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                        ),
                        onTap: () {
                          String url =
                              "https://github.com/ahmedtalal?tab=repositories";
                          _launchUrl(url);
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "gmail",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: YuseiMagic,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.0,
                        ),
                        onTap: () {
                          const String url =
                              "https://mail.google.com/mail/u/0/#inbox";
                          _launchUrl(url);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "could not launch $url";
    }
  }
}
