import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:tchat/firebase/chat/post_crud_servies.dart';
import 'package:tchat/models/post_model.dart';
import 'package:tchat/widgets/button_widget.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class PostDetails extends StatefulWidget {
  PostModel postModel;
  PostDetails({@required this.postModel});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  String message;
  bool isProgress = false;
  var scafolldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  String _content;

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
                    "Post Details",
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
              Container(
                height: height * 0.2,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: YuseiMagic,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "content",
                      labelStyle: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                      filled: true,
                      fillColor: Colors.lightBlue[100],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (input) {
                      if (input.isEmpty) {
                        return "title is required";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        // you code is here >>>
                        _content = value;
                      });
                    },
                    initialValue: widget.postModel.content,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              ButtonWidget(
                hint: "Update Post",
                height: height * 0.08,
                width: width * 0.85,
                onClick: () {
                  setState(() {
                    isProgress = !isProgress;
                  });
                  _updatePost(context);
                },
              ),
              SizedBox(
                height: 12.0,
              ),
              ButtonWidget(
                hint: "Delete Post",
                height: height * 0.08,
                width: width * 0.85,
                onClick: () {
                  setState(() {
                    isProgress = !isProgress;
                  });
                  _deletePost(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePost(BuildContext context) {
    if (formKey.currentState.validate()) {
      PostModel postModel = PostModel(
        widget.postModel.postId,
        _content,
        widget.postModel.ownerId,
        widget.postModel.likes,
        widget.postModel.isFollow,
        widget.postModel.isLike,
        widget.postModel.date,
      );
      var result = PostCrudServices.getInstance().updataData(postModel);
      if (result == true) {
        Navigator.of(context).pop(context);
      }
    }
  }

  void _deletePost(BuildContext context) {
    if (formKey.currentState.validate()) {
      var result = PostCrudServices.getInstance().deleteData(widget.postModel.postId);
      if (result == true) {
        Navigator.of(context).pop(context);
      }
    }
  }
}
