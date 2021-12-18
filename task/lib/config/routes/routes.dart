import 'package:task/insta_app.dart';
import 'package:task/config/routes/routes_const.dart';
import 'package:task/screens/signin.dart';
import 'package:task/screens/signup.dart';
import 'package:task/screens/post_detail.dart';
import 'package:task/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:task/shared/models/user_post_model.dart';

class RouteSetting {
  static RouteSetting? _routeSetting;

  RouteSetting._internal();

  static RouteSetting? getInstance() {
    if (_routeSetting == null) {
      _initializeBloc();
      _routeSetting = RouteSetting._internal();
    }
    return _routeSetting;
  }

  static void _initializeBloc() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.signIn:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case AppRoutes.appScreen:
        return MaterialPageRoute(builder: (_) => AppScreen());
      case AppRoutes.productDetailScreen:
        return MaterialPageRoute(
            builder: (_) =>
                DisplayPostScreen(post: settings.arguments as UserPost));
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
