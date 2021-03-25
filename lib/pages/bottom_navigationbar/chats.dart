import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/pages/chats/people_list.dart';
import 'package:tchat/widgets/chat_view_adapter.dart';
import 'package:tchat/widgets/search_widget.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PeopleList(),
            ),
          );
        },
        child: Icon(
          Icons.people,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.09,
              left: width * 0.03,
              right: width * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: YuseiMagic,
                          fontWeight: FontWeight.bold,
                        ),
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
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ChatViewAdapter();
              },
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}
