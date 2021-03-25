import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/models/user_model.dart';

// ignore: must_be_immutable
class ChatViewAdapter extends StatelessWidget {
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
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
                        CircleAvatar(
                          radius: 20.0,
                          child: Image(
                            image: AssetImage(userImage),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ahmed talal",
                                style: TextStyle(
                                  fontFamily: YuseiMagic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "you:How are you?",
                                style: TextStyle(
                                  fontFamily: YuseiMagic,
                                  fontSize: 14.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: true,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                        child: Text(
                          "+1",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.blue,
                  thickness: 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
