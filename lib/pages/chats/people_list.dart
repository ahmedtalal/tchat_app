import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/widgets/error_widget.dart';
import 'package:tchat/widgets/search_widget.dart';
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 22.0,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "People",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: YuseiMagic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                SearchWidget(
                  onClick: (value) {
                    setState(() {});
                  },
                  heightValue: height * 0.066,
                  hint: "Search",
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
