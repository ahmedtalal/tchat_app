import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/widgets/button_widget.dart';
import 'package:tchat/widgets/search_widget.dart';
import 'package:uuid/uuid.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String message;
  bool isProgress = false;
  var scafolldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scafolldKey,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.08,
            horizontal: width * 0.05,
          ),
          child: ListView(
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
                    "Add Post",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: YuseiMagic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.1,
              ),
              SearchWidget(
                onClick: (value) {
                  setState(() {
                    message = value;
                  });
                },
                heightValue: height * 0.2,
                hint: "add your post",
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ButtonWidget(
                hint: "Add Post",
                height: height * 0.08,
                width: width * 0.85,
                onClick: () {
                  setState(() {
                    isProgress = !isProgress;
                  });
                  _validPost(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validPost(BuildContext context) async {
    if (message.isEmpty) {
      creareSnackbar("you must write your content!");
    } else {
      var uid = Uuid();
      String postId = uid.v1();
      String userId = FirebaseAuth.instance.currentUser.uid;
      DateTime now = DateTime.now();
      String date = DateFormat.yMd().add_jm().format(now);
      List<String> isLike = [];
      List<String> isFollow = [];
      PostModel post =
          PostModel(postId, message, userId, 0, isLike, isFollow, date);
      try {
        var result = await PostCrudServices.getInstance().addData(post);
        if (result == true) {
          Navigator.of(context).pop(context);
        } else {
          creareSnackbar("error in adding process");
        }
      } catch (e) {
        creareSnackbar(e.toString());
      }
    }
  }

  void creareSnackbar(String message) {
    setState(() {
      isProgress = !isProgress;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
