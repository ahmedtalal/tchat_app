import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tchat/pages/bottom_navigationbar/nav_bar.dart';
import 'package:tchat/pages/splash_screen.dart';
import 'package:tchat/providers/bloc/follow_bloc/follow_bloc.dart';
import 'package:tchat/providers/darkmode_provider.dart';
import 'firebase/auth/auth_services.dart';

main(List<String> args) async {
  WidgetsFlutterBinding
      .ensureInitialized(); // is used to interact with firebase engine >>
  await Firebase.initializeApp();
  runApp(WhatsApp());
}

class WhatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DarkThemeNotifier(),
        ),
        BlocProvider<FollowBloc>(
          create: (context) {
            return FollowBloc();
          },
        ),
      ],
      child: Consumer<DarkThemeNotifier>(
        builder: (context, DarkThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: notifier.darhTheme ? dark : light,
            home: StreamBuilder<User>(
              stream: AuthServices.getInstance().checkCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NavBar();
                } else {
                  return SplashScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
