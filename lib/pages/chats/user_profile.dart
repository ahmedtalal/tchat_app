import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/chat/follow_crud_Services.dart';
import 'package:tchat/firebase/chat/follower_crud_Services.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/providers/darkmode_provider.dart';
import 'package:tchat/widgets/post_view_adapter.dart';
import 'package:tchat/widgets/user_view_adapter.dart';

// ignore: must_be_immutable
class UserProfile extends StatefulWidget {
  String userId;
  List<PostModel> posts;
  String userName;
  UserProfile({
    @required this.userId,
    @required this.posts,
    @required this.userName,
  });
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  List<PostModel> postList = [];
  bool postTap = true;
  bool followerTap = false;
  bool followingTap = false;
  int postCount = 0;
  @override
  void initState() {
    super.initState();
    widget.posts.forEach((element) {
      if (element.ownerId == widget.userId) {
        postList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height * 0.23),
          child: Consumer<DarkThemeNotifier>(
            builder: (context, DarkThemeNotifier notifier, child) {
              return AppBar(
                toolbarHeight: height * 0.12,
                backgroundColor:
                    notifier.darhTheme ? Colors.grey[850] : Colors.white,
                elevation: 0.1,
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "${widget.userName} Profile",
                  style: TextStyle(
                    fontFamily: YuseiMagic,
                    fontSize: 15.0,
                    color: notifier.darhTheme ? Colors.white : Colors.black,
                  ),
                ),
                actions: [
                  Visibility(
                    visible: widget.userId ==
                            AuthCrudServices.getInstance().getUser().uid
                        ? false
                        : true,
                    child: IconButton(
                      icon: Image.asset(
                        followImage,
                        color: Colors.blue,
                        height: 20.0,
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  )
                ],
                bottom: TabBar(
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue,
                  ),
                  tabs: [
                    Tab(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.blueAccent,
                            width: 1,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${postList.length.toString()}",
                                style: TextStyle(
                                  fontFamily: YuseiMagic,
                                  color:
                                      notifier.darhTheme ? Colors.white : null,
                                ),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  fontFamily: YuseiMagic,
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      notifier.darhTheme ? Colors.white : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FollowerCrudServices.getInstance()
                          .retrieveAllData(
                              FollowCrudServices.getInstance().getUser().uid),
                      builder: (context, snapshot) {
                        bool result;
                        if (!snapshot.hasData) {
                          result = false;
                        } else {
                          result = true;
                        }
                        return Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    result == false
                                        ? "0"
                                        : snapshot.data.size.toString(),
                                    style: TextStyle(
                                      fontFamily: YuseiMagic,
                                      color: notifier.darhTheme
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                      fontFamily: YuseiMagic,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: notifier.darhTheme
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: FollowCrudServices.getInstance().retrieveAllData(
                          FollowCrudServices.getInstance().getUser().uid),
                      builder: (context, snapshot) {
                        bool result;
                        if (!snapshot.hasData) {
                          result = false;
                        } else {
                          result = true;
                        }
                        return Tab(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.blueAccent,
                                width: 1,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    result == false
                                        ? "0"
                                        : snapshot.data.size.toString(),
                                    style: TextStyle(
                                      fontFamily: YuseiMagic,
                                      color: notifier.darhTheme
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                  Text(
                                    "Following",
                                    style: TextStyle(
                                      fontFamily: YuseiMagic,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.bold,
                                      color: notifier.darhTheme
                                          ? Colors.white
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        body: TabBarView(children: [
          // post partion
          postsValidation(height),

          // followers partion  ????????????????????
          followersValidate(height),

          // followoing parttion>>>>>>>>>>>>>>>>>>>>>>
          followingValidate(height),
        ]),
      ),
    );
  }

  Widget followingValidate(double height) {
    if (widget.userId == FollowCrudServices.getInstance().getUser().uid) {
      return StreamBuilder<QuerySnapshot>(
        stream: FollowCrudServices.getInstance()
            .retrieveAllData(FollowCrudServices.getInstance().getUser().uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.size == 0) {
            return Center(
              child: Container(
                height: height * 0.5,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(emptySearch),
                      height: height * 0.32,
                    ),
                    Text(
                      "Nothing at this time",
                      style: TextStyle(
                        fontFamily: YuseiMagic,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((doc) {
                var value = doc.data();
                String id = value["id"].toString();
                print(id);
                return UserViewAdapter(userId: id);
              }).toList(),
            );
          }
        },
      );
    } else {
      return Center(
        child: Container(
          height: height * 0.5,
          child: Column(
            children: [
              Image(
                image: AssetImage(emptySearch),
                height: height * 0.32,
              ),
              Text(
                "Nothing at this time",
                style: TextStyle(
                  fontFamily: YuseiMagic,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget followersValidate(double height) {
    if (widget.userId == FollowerCrudServices.getInstance().getUser().uid) {
      return StreamBuilder<QuerySnapshot>(
        stream: FollowerCrudServices.getInstance()
            .retrieveAllData(FollowerCrudServices.getInstance().getUser().uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.size == 0) {
            return Center(
              child: Container(
                height: height * 0.5,
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(emptySearch),
                      height: height * 0.32,
                    ),
                    Text(
                      "No followers at this time",
                      style: TextStyle(
                        fontFamily: YuseiMagic,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.docs.map((doc) {
                var value = doc.data();
                String id = value["id"].toString();
                print(id);
                return UserViewAdapter(userId: id);
              }).toList(),
            );
          }
        },
      );
    } else {
      return Center(
        child: Container(
          height: height * 0.5,
          child: Column(
            children: [
              Image(
                image: AssetImage(emptySearch),
                height: height * 0.32,
              ),
              Text(
                "Nothing at this time",
                style: TextStyle(
                  fontFamily: YuseiMagic,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget postsValidation(double height) {
    if (postList.length == 0) {
      return Center(
        child: Container(
          height: height * 0.5,
          child: Column(
            children: [
              Image(
                image: AssetImage(emptySearch),
                height: height * 0.32,
              ),
              Text(
                "No posts at this time",
                style: TextStyle(
                  fontFamily: YuseiMagic,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          //PostModel postModel = postList[index];
          return PostViewApdater(
            postModel: postList[index],
            postList: widget.posts,
            position: 0,
          );
        },
      );
    }
  }
}
