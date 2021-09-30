import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/chat/follow_crud_Services.dart';
import 'package:tchat/firebase/chat/follower_crud_Services.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/pages/chats/chat_room.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_Events.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_States.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_bloc.dart';
import 'package:tchat/providers/darkmode_provider.dart';
import 'package:tchat/widgets/post_view_adapter.dart';

// ignore: must_be_immutable
class ProfileDetails extends StatefulWidget {
  List<PostModel> list;
  String userId;
  ProfileDetails({
    @required this.list,
    @required this.userId,
  });
  @override
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  List<PostModel> postList = [];
  String name, image;
  bool isfollow = false;

  @override
  void initState() {
    super.initState();
    widget.list.forEach((element) {
      if (element.ownerId == widget.userId) {
        postList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var provider = BlocProvider.of<FollowBloc>(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<DarkThemeNotifier>(
              builder: (context, DarkThemeNotifier notifier, child) {
                return Container(
                  height: height * 0.38,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: notifier.darhTheme ? Colors.grey[850] : Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.07,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Profile Details",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: YuseiMagic,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                              icon: Image.asset(
                                chatImage,
                                color: Colors.white,
                                height: 17.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (c) => ChatRoom(
                                      userId: widget.userId,
                                      name: name,
                                      image: image,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      StreamBuilder(
                        stream: AuthCrudServices.getInstance()
                            .getSpecificData(widget.userId),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          bool result = false;
                          if (!snapshot.hasData) {
                            result = false;
                          } else {
                            result = true;
                          }
                          var docs = snapshot.data;
                          name = docs["name"];
                          image = "null";
                          if (docs["image"] == "null") {
                            image = userImage;
                          } else {
                            image = docs["image"];
                          }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 19.0,
                                      child: Image(image: AssetImage(image)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            result == false
                                                ? "Unknown"
                                                : docs["email"],
                                            style: TextStyle(
                                              fontFamily: YuseiMagic,
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            result == false ? "Unknown" : name,
                                            style: TextStyle(
                                              fontFamily: YuseiMagic,
                                              color: Colors.white60,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                StreamBuilder(
                                  stream: FollowCrudServices.getInstance()
                                      .getSpecificData(widget.userId),
                                  builder: (context, snapshot) {
                                    var id = snapshot.data;
                                    String currentUser =
                                        AuthCrudServices.getInstance()
                                            .getUser()
                                            .uid;
                                    bool res;
                                    try {
                                      res = id["id"] == widget.userId
                                          ? true
                                          : false;
                                    } catch (e) {
                                      res = false;
                                    }
                                    if (snapshot.data == null) {
                                      isfollow = false;
                                    } else if (res == true) {
                                      isfollow = true;
                                    }
                                    if (widget.userId == currentUser) {
                                      return Visibility(
                                        visible: false,
                                        child: Text("null"),
                                      );
                                    } else {
                                      return BlocListener<FollowBloc,
                                          FollowStates>(
                                        listener: (context, state) {
                                          if (state is FollowedState) {
                                            snackbarValidate(
                                                state.message, context);
                                          } else if (state is UnFollowedState) {
                                            snackbarValidate(
                                                state.message, context);
                                          } else if (state
                                              is FollowExceptionState) {
                                            snackbarValidate(
                                                state.error, context);
                                          }
                                        },
                                        child: BlocBuilder<FollowBloc,
                                            FollowStates>(
                                          builder: (context, state) {
                                            return IconButton(
                                              icon: isfollow == true
                                                  ? Image.asset(unfollowMe)
                                                  : Image.asset(followMe),
                                              onPressed: () {
                                                if (isfollow == true) {
                                                  // un follow me action
                                                  setState(() {
                                                    isfollow = false;
                                                  });
                                                  provider.ownerId =
                                                      widget.userId;
                                                  provider.add(
                                                      RemoveFollowEvents());
                                                } else {
                                                  // follow me action
                                                  provider.ownerId =
                                                      widget.userId;
                                                  provider
                                                      .add(AddFollowEvent());
                                                  isfollow = true;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13.0, right: 15.0),
                        child: Container(
                          height: height * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: notifier.darhTheme
                                ? Colors.grey[850]
                                : Colors.white,
                            border: notifier.darhTheme
                                ? Border.all(color: Colors.grey, width: 1)
                                : null,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: YuseiMagic,
                                        color: notifier.darhTheme
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    Text(
                                      postList.length.toString(),
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontFamily: YuseiMagic,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FollowCrudServices.getInstance()
                                      .retrieveAllData(widget.userId),
                                  builder: (context, snapshot) {
                                    bool flag;
                                    if (!snapshot.hasData) {
                                      flag = false;
                                    } else {
                                      flag = true;
                                    }
                                    return Column(
                                      children: [
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: YuseiMagic,
                                            color: notifier.darhTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          flag == true
                                              ? snapshot.data.size.toString()
                                              : "0",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontFamily: YuseiMagic,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FollowerCrudServices.getInstance()
                                      .retrieveAllData(widget.userId),
                                  builder: (context, snapshot) {
                                    bool flag;
                                    if (!snapshot.hasData) {
                                      flag = false;
                                    } else {
                                      flag = true;
                                    }
                                    return Column(
                                      children: [
                                        Text(
                                          "Followers",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontFamily: YuseiMagic,
                                            color: notifier.darhTheme
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        Text(
                                          flag == true
                                              ? snapshot.data.size.toString()
                                              : "0",
                                          style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontFamily: YuseiMagic,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Posts",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: YuseiMagic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return PostViewApdater(
                    postModel: postList[index],
                    postList: widget.list,
                    position: 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
