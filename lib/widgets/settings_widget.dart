import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tchat/constants.dart';
import 'package:tchat/providers/darkmode_provider.dart';

// ignore: must_be_immutable
class SettingsWidget extends StatelessWidget {
  Function onClick;
  String hint;
  IconData icon;
  Color color;
  Color iconColor;
  SettingsWidget({
    @required this.onClick,
    @required this.hint,
    @required this.icon,
    @required this.color,
    @required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 30.0,
                width: 30.0,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: color,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                  color: color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7.0, right: 7.0),
                child: Text(
                  "$hint",
                  style: TextStyle(
                    fontFamily: YuseiMagic,
                    fontSize: 16.0,
                    fontWeight:
                        hint == "Logout" ? FontWeight.bold : FontWeight.normal,
                    color: hint == "Logout" ? Colors.blue : null,
                  ),
                ),
              ),
            ],
          ),
          checkDarkWidget(),
        ],
      ),
    );
  }

  Widget checkDarkWidget() {
    if (hint == "Dark Mode") {
      return StatefulBuilder(
        builder: (context, setState) {
          return Consumer<DarkThemeNotifier>(
            builder: (context, DarkThemeNotifier notifier, child) {
              return Switch(
                activeColor: Colors.blue,
                inactiveTrackColor: Colors.grey,
                value: notifier.darhTheme,
                onChanged: (value) {
                  setState(
                    () {
                      notifier.setTheme();
                    },
                  );
                },
              );
            },
          );
        },
      );
    } else {
      return Consumer<DarkThemeNotifier>(
        builder: (context, DarkThemeNotifier notifier, child) {
          return Icon(
            Icons.arrow_right_rounded,
            size: 30.0,
            color: notifier.darhTheme ? Colors.white : Colors.black,
          );
        },
      );
    }
  }
}
