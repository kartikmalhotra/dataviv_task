import 'dart:async';

import 'package:task/insta_app.dart';
import 'package:task/config/application.dart';
import 'package:task/config/screen_config.dart';
import 'package:task/screens/signin.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    /// Apply a Timer for 3 seconds for Splash Screen
    _displaySplashScreen();
  }

  void _displaySplashScreen() {
    Timer(Duration(seconds: 2), () {
      if (InstaUser.isUserLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AppScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SetAppScreenConfiguration.init(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "INSTA",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: AppSpacing.xxxxl),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
