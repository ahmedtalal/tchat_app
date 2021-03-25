import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/chat/follow_crud_Services.dart';
import 'package:tchat/firebase/chat/follower_crud_Services.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/pages/chats/chat_room.dart';
import 'package:tchat/pages/chats/profile_details.dart';
import 'package:tchat/pages/chats/user_profile.dart';
import 'package:tchat/pages/posts/post_details.dart';

// ignore: must_be_immutable
class PostViewApdater extends StatelessWidget {
  PostModel postModel;
  List<PostModel> postList;
  int position;
  PostViewApdater({
    @required this.postModel,
    @required this.postList,
    @required this.position,
  });
  String userName, userImageProf;
  bool isfollow = false;
  List<dynamic> likeList = [];
  bool likeResult = false;
  checkLikes() {
    likeList = postModel.isLike;
    if (likeList.isEmpty) {
      likeResult = false;
    } else {
      likeList.forEach((element) {
        if (element.toString() ==
            PostCrudServices.getInstance().getUser().uid) {
          likeResult = true;
          return;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLikes();
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (postModel.ownerId ==
              PostCrudServices.getInstance().getUser().uid) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (c) => PostDetails(postModel: postModel),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            
            border: Border.all(color: Colors.grey, width: 0.33),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (position == 1 &&
                                postModel.ownerId ==
                                    PostCrudServices.getInstance()
                                        .getUser()
                                        .uid) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserProfile(
                                    userId: postModel.ownerId,
                                    posts: postList,
                                    userName: userName,
                                  ),
                                ),
                              );
                            } else if (position != 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileDetails(
                                    list: postList,
                                    userId: postModel.ownerId,
                                  ),
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            radius: 18.0,
                            child: Image(
                              image: AssetImage(userImage),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              StreamBuilder(
                                stream: AuthCrudServices.getInstance()
                                    .getSpecificData(postModel.ownerId),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text(
                                      "UnKnown",
                                      style: TextStyle(
                                        fontFamily: YuseiMagic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  var userDocument = snapshot.data;
                                  userName = userDocument["name"];
                                  if (userDocument["image"] == "null") {
                                    userImageProf = userImage;
                                  } else {
                                    userImageProf = userDocument["image"];
                                  }
                                  return new Text(
                                    userDocument["name"],
                                    style: TextStyle(
                                      fontFamily: YuseiMagic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                postModel.date,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: YuseiMagic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: FollowCrudServices.getInstance()
                          .getSpecificData(postModel.ownerId),
                      builder: (context, snapshot) {
                        var id = snapshot.data;
                        String currentUser =
                            AuthCrudServices.getInstance().getUser().uid;
                        bool res;
                        try {
                          res = id["id"] == postModel.ownerId ? true : false;
                        } catch (e) {
                          res = false;
                        }
                        if (snapshot.data == null) {
                          isfollow = false;
                        } else if (res == true) {
                          isfollow = true;
                        }
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Visibility(
                              visible: isfollow == true ||
                                      postModel.ownerId == currentUser
                                  ? false
                                  : true,
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    addFollowingUser();
                                    isfollow = true;
                                  });
                                },
                                child: Text(
                                  "+ Follow",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontFamily: YuseiMagic,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  width: double.infinity,
                  height: height * 0.09,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        postModel.content,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: YuseiMagic,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          children: [
                            IconButton(
                              icon: likeResult == false
                                  ? Image.asset(
                                      likesImage,
                                      color: Colors.grey[500],
                                      height: 20.0,
                                    )
                                  : Image.asset(
                                      likesImage,
                                      color: Colors.blue,
                                      height: 20.0,
                                    ),
                              onPressed: () {
                                setState(() {
                                  handleLikeAction(postModel);
                                });
                              },
                            ),
                            Text(
                              "${postModel.likes} likes",
                              style: TextStyle(
                                fontFamily: YuseiMagic,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            shareImage,
                            color: Colors.grey[500],
                            height: 20.0,
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          "Share",
                          style: TextStyle(
                            fontFamily: YuseiMagic,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            chatImage,
                            color: Colors.grey[500],
                            height: 20.0,
                          ),
                          onPressed: () {
                            String userAuthId =
                                AuthCrudServices.getInstance().getUser().uid;
                            if (postModel.ownerId != userAuthId) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    userId: postModel.ownerId,
                                    name: userName,
                                    image: userImageProf,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        Text(
                          "Message",
                          style: TextStyle(
                            fontFamily: YuseiMagic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // handle when user clicks on like button
  void handleLikeAction(PostModel post) {
    List<dynamic> likeList = [];
    List<dynamic> list = post.isLike;
    int likeCountIncrement = post.likes + 1;
    int likeCountDecrement = post.likes - 1;
    bool flag;
    var result;
    if (list.isNotEmpty) {
      for (var i = 0; i < list.length; i++) {
        if (list[i] == PostCrudServices.getInstance().getUser().uid) {
          list.removeAt(i);
          flag = true;
          break;
        } else {
          likeList.add(list[i]);
          flag = false;
        }
      }
    } else {
      flag = false;
    }
    if (flag == true) {
      PostModel postModel = PostModel(
        post.postId,
        post.content,
        post.ownerId,
        likeCountDecrement,
        post.isFollow,
        list,
        post.date,
      );
      result = PostCrudServices.getInstance().updataData(postModel);
    } else {
      likeList.add(PostCrudServices.getInstance().getUser().uid);
      PostModel postModel = PostModel(
        post.postId,
        post.content,
        post.ownerId,
        likeCountIncrement,
        post.isFollow,
        likeList,
        post.date,
      );
      result = PostCrudServices.getInstance().updataData(postModel);
    }
    if (result == true) {
      print("updating successfully");
    } else {
      print("updating error");
    }
  }

  void addFollowingUser() async {
    String ownerId = postModel.ownerId;
    var result = await FollowCrudServices.getInstance().addData(ownerId);
    var followerResult =
        await FollowerCrudServices.getInstance().addData(ownerId);
    if (result == true || followerResult == true) {
      print("successfully operation");
    } else {
      print("error in operation");
    }
  }
}
