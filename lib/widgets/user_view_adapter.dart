import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
import 'package:tchat/pages/chats/chat_room.dart';

// ignore: must_be_immutable
class UserViewAdapter extends StatelessWidget {
  String userId;
  UserViewAdapter({@required this.userId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                stream: AuthCrudServices.getInstance().getSpecificData(userId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var doc = snapshot.data;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            child: Image(
                              image: AssetImage(userImage),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              doc["name"],
                              style: TextStyle(
                                fontFamily: YuseiMagic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Image.asset(
                          chatImage,
                          color: Colors.blue,
                          height: 22.0,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatRoom(
                                userId: doc["id"],
                                name: doc["name"],
                                image: doc["image"],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
              Divider(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
