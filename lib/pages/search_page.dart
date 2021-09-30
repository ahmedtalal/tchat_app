import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/chat_model.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/models/user_model.dart';
import 'package:tchat/widgets/error_widget.dart';
import 'package:tchat/widgets/post_view_adapter.dart';
import 'package:tchat/widgets/search_widget.dart';
import 'package:tchat/widgets/user_view_adapter.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  String type;
  SearchPage({
    @required this.type,
  });
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<PostModel> allPosts = [];
  List<PostModel> fliterPosts = [];
  List<UserModel> allUsers = [];
  List<UserModel> fliterUsers = [];
  List<ChatModel> allChats = [];
  List<ChatModel> fliterChats = [];
  bool isConnected = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.09),
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
                  "search",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: YuseiMagic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13.0),
            StreamBuilder<QuerySnapshot>(
              stream: widget.type == "posts"
                  ? PostCrudServices.getInstance().retrieveAllData(null)
                  : AuthCrudServices.getInstance().retrieveAllData(null),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print("stream false");
                  isConnected = false;
                } else if (snapshot.hasData) {
                  print("done");
                  allPosts.clear();
                  allUsers.clear();
                  allChats.clear();
                  snapshot.data.docs.forEach((DocumentSnapshot element) {
                    if (widget.type == "posts") {
                      PostModel post = PostModel.fromMap(element.data());
                      allPosts.add(post);
                    } else {
                      UserModel user = UserModel.fromMap(element.data());
                      allUsers.add(user);
                    }
                  });
                }
                return SearchWidget(
                  onClick: (value) {
                    setState(() {
                      if (widget.type == "posts") {
                        fliterPosts.clear();
                        allPosts.forEach((PostModel model) {
                          if (model.content
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            fliterPosts.add(model);
                          }
                        });
                      } else if (widget.type == "users") {
                        fliterUsers.clear();
                        allUsers.forEach((UserModel model) {
                          if (model.name
                              .toLowerCase()
                              .contains(value.toLowerCase())) {
                            fliterUsers.add(model);
                          }
                        });
                      } else {}
                      if (value.isEmpty) {
                        fliterPosts.clear();
                        fliterUsers.clear();
                        fliterChats.clear();
                      }
                    });
                  },
                  heightValue: size.height * 0.066,
                  hint: "Search",
                );
              },
            ),
            const SizedBox(height: 7.0),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 100.0,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            _fliterationTasks(size),
          ],
        ),
      ),
    );
  }

  Widget _fliterationTasks(var size) {
    print("${fliterPosts.length} fliter");
    if (fliterPosts.isEmpty && widget.type == "posts") {
      print("list empty");
      return Center(
        child: ErrorsWidget(
          hint: "No ${widget.type} at this time",
          type: "error",
          height: size.height * 0.3,
        ),
      );
    } else if (fliterUsers.isEmpty && widget.type == "users") {
      print("list empty");
      return Center(
        child: ErrorsWidget(
          hint: "No ${widget.type} at this time",
          type: "error",
          height: size.height * 0.3,
        ),
      );
    } else if (fliterChats.isEmpty && widget.type == "chats") {
      return Center(
        child: ErrorsWidget(
          hint: "No ${widget.type} at this time",
          type: "error",
          height: size.height * 0.3,
        ),
      );
    } else if (isConnected == false) {
      return Center(
        child: ErrorsWidget(
          hint: "No ${widget.type} at this time",
          type: "error",
          height: size.height * 0.3,
        ),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount:
              widget.type == "posts" ? fliterPosts.length : fliterUsers.length,
          itemBuilder: (context, index) {
            if (widget.type == "posts") {
              return PostViewApdater(
                postModel: fliterPosts[index],
                postList: allPosts,
                position: 1,
              );
            } else {
              return UserViewAdapter(userId: fliterUsers[index].id);
            }
          },
        ),
      );
    }
  }
}
