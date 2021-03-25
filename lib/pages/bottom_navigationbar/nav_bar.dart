import 'package:flutter/material.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/pages/bottom_navigationbar/chats.dart';
import 'package:tchat/pages/bottom_navigationbar/posts.dart';
import 'package:tchat/pages/bottom_navigationbar/settings.dart';
import 'package:tchat/pages/bottom_navigationbar/status.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  List<Widget> widgets = [
    Chats(),
    Posts(),
    Status(),
    Settings(),
  ];

  void onItemTapped(int indext) {
    setState(() {
      selectedIndex = indext;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 8.0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        iconSize: 20.0,
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(chatImage,color: Colors.grey,height: 20.0,),
            activeIcon: Image.asset(chatImage,color: Colors.blue,height: 20.0,),
            label: "Chats",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(postImage,color: Colors.grey,height: 20.0,),
            activeIcon: Image.asset(postImage,color: Colors.blue,height: 20.0,),
            label: "Posts",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(statusImage,color: Colors.grey,height: 20.0,),
            activeIcon: Image.asset(statusImage,color: Colors.blue,height: 20.0,),
            label: "Status",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(settingImage,color: Colors.grey,height: 20.0,),
            activeIcon: Image.asset(settingImage,color: Colors.blue,height: 20.0,),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
