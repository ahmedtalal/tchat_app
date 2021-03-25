import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/pages/posts/add_post.dart';
import 'package:tchat/widgets/post_view_adapter.dart';
import 'package:tchat/widgets/search_widget.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  var height, width;
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.09,
              left: width * 0.03,
              right: width * 0.03,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        StreamBuilder(
                          stream: AuthCrudServices.getInstance()
                              .getSpecificData(
                                  AuthCrudServices.getInstance().getUser().uid),
                          builder: (context, snapshot) {
                            String image;
                            var document = snapshot.data;
                            if (!snapshot.hasData ||
                                document["image"] == "null") {
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
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            "Posts",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: YuseiMagic,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPost(),
                      )),
                      child: Icon(
                        Icons.add_circle,
                        size: 22.0,
                        color: Colors.blue,
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
              stream: PostCrudServices.getInstance().retrieveAllData(null),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return noPostsWidget("loading");
                }
                if (!snapshot.hasData) {
                  return noPostsWidget("error");
                }
                List<PostModel> posts = [];
                snapshot.data.docs.forEach((QueryDocumentSnapshot element) {
                  PostModel postModel = PostModel.fromMap(element.data());
                  posts.add(postModel);
                });
                return ListView(
                  children: snapshot.data.docs.map((doc) {
                    PostModel post = PostModel.fromMap(doc.data());
                    return PostViewApdater(
                      postModel: post,
                      postList: posts,
                      position: 1,
                    );
                  }).toList(),
                );
              },
            ),
            flex: 3,
          )
        ],
      ),
    );
  }

  Widget noPostsWidget(String type) {
    if (type == "loading") {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: Container(
        height: height * 0.5,
        child: Column(
          children: [
            Image(
              image: AssetImage(noWifi),
              height: height * 0.3,
            ),
            Text(
              "No posts at this time",
              style: TextStyle(
                fontFamily: YuseiMagic,
                fontSize: 20.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
