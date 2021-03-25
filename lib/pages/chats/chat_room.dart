import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/providers/darkmode_provider.dart';

// ignore: must_be_immutable
class ChatRoom extends StatefulWidget {
  String userId, name, image;
  ChatRoom({@required this.userId, @required this.name, @required this.image});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Consumer<DarkThemeNotifier>(
      builder: (context, DarkThemeNotifier notifier, child) {
        return SafeArea(
          top: false,
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor:
                notifier.darhTheme ? Colors.grey[700] : Colors.grey[400],
            appBar: AppBar(
              toolbarHeight: height * 0.11,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor:
                  notifier.darhTheme ? Colors.grey[850] : Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      CircleAvatar(
                        child: Image(
                          image: widget.image == "null"
                              ? AssetImage(userImage)
                              : AssetImage(widget.image),
                        ),
                        maxRadius: 18.0,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: YuseiMagic,
                                color: notifier.darhTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Online",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.video_call_rounded,
                    size: 25.0,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text("Sorry,It is not activated now!")),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.call,
                    size: 25.0,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text("Sorry,It is not activated now!")),
                    );
                  },
                ),
              ],
            ),
            body: Stack(
              children: <Widget>[
                ListView(
                  children: [],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: height * 0.08,
                    width: double.infinity,
                    color: notifier.darhTheme ? Colors.grey[850] : Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(
                                color: notifier.darhTheme
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
