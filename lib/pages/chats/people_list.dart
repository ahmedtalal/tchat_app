import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/pages/search_page.dart';
import 'package:tchat/widgets/error_widget.dart';
import 'package:tchat/widgets/user_view_adapter.dart';

class PeopleList extends StatefulWidget {
  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  List<UserModel> userList = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.09,
              left: width * 0.04,
              right: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    StreamBuilder(
                      stream: AuthCrudServices.getInstance().getSpecificData(
                          AuthCrudServices.getInstance().getUser().uid),
                      builder: (context, snapshot) {
                        String image;
                        var document = snapshot.data;
                        if (!snapshot.hasData || document["image"] == "null") {
                          image = userImage;
                        } else {
                          print("object");
                          image = document["image"];
                        }
                        return CircleAvatar(
                          radius: 15.0,
                          child: Image(
                            image: AssetImage(image),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: YuseiMagic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPage(type: "users"),
                  )),
                  child: Icon(
                    Icons.search,
                    size: 22.0,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: AuthCrudServices.getInstance().retrieveAllData(null),
              builder: (context, snapShot) {
                if (snapShot.hasError) {
                  return ErrorsWidget(
                    hint: "No people at this time",
                    type: "error",
                    height: height * 0.3,
                  );
                }
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return ErrorsWidget(
                    hint: "No people at this time",
                    type: "loading",
                    height: height * 0.3,
                  );
                }
                userList.clear();
                snapShot.data.docs.forEach((QueryDocumentSnapshot element) {
                  UserModel userModel = UserModel.fromMap(element.data());
                  if (userModel.id !=
                      AuthCrudServices.getInstance().getUser().uid) {
                    userList.add(userModel);
                  }
                });
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return UserViewAdapter(userId: userList[index].id);
                  },
                );
              },
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
