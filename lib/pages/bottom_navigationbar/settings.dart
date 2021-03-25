import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/auth/auth_services.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/pages/authentication/register.dart';
import 'package:tchat/pages/chats/user_profile.dart';
import 'package:tchat/setting_components/contact_us.dart';
import 'package:tchat/setting_components/rate_app.dart';
import 'package:tchat/widgets/settings_widget.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String image;
  String name;
  String id;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.08,
          horizontal: width * 0.05,
        ),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: YuseiMagic,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            StreamBuilder(
              stream: AuthCrudServices.getInstance().getSpecificData(
                  AuthCrudServices.getInstance().getUser().uid),
              builder: (context, snapShot) {
                if (!snapShot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(userImage),
                        height: height * 0.08,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "UnKnown",
                        style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: YuseiMagic,
                        ),
                      ),
                    ],
                  );
                }
                var document = snapShot.data;
                name = document["name"];
                id = document["id"];
                if (document["image"] == "null") {
                  image = userImage;
                } else {
                  image = document["image"];
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image(
                          image: AssetImage(image),
                          height: height * 0.08,
                        ),
                        Positioned(
                          bottom: 0,
                          top: height*0.044,
                          left: 21,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 18.0,
                              color: Colors.blue[700],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: YuseiMagic,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: height * 0.03,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: PostCrudServices.getInstance().retrieveAllData(null),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SettingsWidget(
                    onClick: () {},
                    hint: "My profile",
                    icon: Icons.person,
                    color: Colors.deepOrange[100],
                    iconColor: Colors.deepOrange[400],
                  );
                }
                List<PostModel> list = [];
                snapshot.data.docs.forEach((element) {
                  PostModel postModel = PostModel.fromMap(element.data());
                  if (postModel.ownerId == id) {
                    list.add(postModel);
                  }
                });
                return SettingsWidget(
                  onClick: () {
                    String id = AuthCrudServices.getInstance().getUser().uid;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserProfile(
                          userId: id,
                          posts: list,
                          userName: name,
                        ),
                      ),
                    );
                  },
                  hint: "My profile",
                  icon: Icons.person,
                  color: Colors.deepOrange[100],
                  iconColor: Colors.deepOrange[400],
                );
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
              onClick: () {},
              hint: "Share App",
              icon: Icons.share,
              color: Colors.pink[100],
              iconColor: Colors.pink[300],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
              onClick: () {},
              hint: "Dark Mode",
              icon: Icons.nights_stay,
              color: Colors.teal[50],
              iconColor: Colors.teal[300],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
                onClick: () {},
                hint: "Change language",
                icon: Icons.language,
                color: Colors.purple[100],
                iconColor: Colors.purple[400]),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => ContactUs(),
                  ),
                );
              },
              hint: "Contact us",
              icon: Icons.phone,
              color: Colors.amber[100],
              iconColor: Colors.amber,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
              onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => RateApp(),
                  ),
                );
              },
              hint: "Rate app",
              icon: Icons.star,
              color: Colors.orange[100],
              iconColor: Colors.orange[400],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SettingsWidget(
              onClick: () async {
                await AuthServices.getInstance().logOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Register(),
                ));
              },
              hint: "Logout",
              icon: Icons.logout,
              color: Colors.lime[100],
              iconColor: Colors.lime[700],
            ),
          ],
        ),
      ),
    );
  }
}
