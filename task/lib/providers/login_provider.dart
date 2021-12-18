import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/config/application.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthenticationProvider with ChangeNotifier {
  Status _status = Status.Uninitialized;

  AuthenticationProvider();

  Status get status => _status;

  Future<void> signInGoogle() async {
    _status = Status.Authenticating;

    notifyListeners();

    final response =
        await Application.firebaseAuthentication!.signInWithGoogle();

    if (response is User) {
      /// Store Data in Insta User class
      InstaUser.storeUserInfoGoogleSignIn(response);

      /// Store data in secure storage
      Application.secureStorageService!.username =
          Future.value(response.displayName);
      Application.secureStorageService!.email = Future.value(response.email);
      Application.storageService!.isUserLoggedIn = true;
      _status = Status.Authenticated;
    } else {
      _status = Status.Unauthenticated;
    }

    notifyListeners();
  }

  Future signOut() async {
    // _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }
}
