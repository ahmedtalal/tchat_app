import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/firebase/auth/auth_crud_services.dart';
class Status extends StatefulWidget {
  @override
  _StatusState createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.06,
            ),
            Row(
              children: [
                StreamBuilder(
                  stream: AuthCrudServices.getInstance().getSpecificData(
                      AuthCrudServices.getInstance().getUser().uid),
                  builder: (context, snapshot) {
                    String image ;
                    var document = snapshot.data;
                    if (!snapshot.hasData || document["image"] == "null") {
                      image = userImage ;
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
                    "Status",
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
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      child: Image(
                        image: AssetImage(userImage),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "My status",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: YuseiMagic,
                        ),
                      ),
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 23.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              "Recent Updates",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: YuseiMagic,
              ),
            ),
            SizedBox(
              height: height * 0.013,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28.0,
                            child: Image(
                              image: AssetImage(userImage),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Ahmed Talal",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: YuseiMagic,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "today,12:30 AM",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
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
