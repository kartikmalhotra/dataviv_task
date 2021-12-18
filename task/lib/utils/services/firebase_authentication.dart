import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task/config/application.dart';

class FirebaseAuthenticationSerive {
  static FirebaseAuthenticationSerive? instance;
  static FirebaseAuth? firebaseAuthInstance;

  static FirebaseAuthenticationSerive getInstance() {
    if (instance == null) {
      instance = FirebaseAuthenticationSerive._internal();
    }

    if (firebaseAuthInstance == null) {
      /// Create a Firebase Auth Instance
      firebaseAuthInstance = FirebaseAuth.instance;
    }
    return instance!;
  }

  FirebaseAuthenticationSerive._internal();

  /// This Function is used to create New Firebase user
  Future<dynamic> createNewUser(String email, String password) async {
    try {
      UserCredential _userCredential = await firebaseAuthInstance!
          .createUserWithEmailAndPassword(email: email, password: password);
      return _userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  /// This Function is used to Sign in with email password
  Future<dynamic> signInWithEmail(String email, String password) async {
    try {
      UserCredential _userCredential = await firebaseAuthInstance!
          .signInWithEmailAndPassword(email: email, password: password);

      return _userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  /// This function is to use signIn with Google
  Future<dynamic> signInWithGoogle() async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await firebaseAuthInstance!.signInWithCredential(credential);

        user = userCredential.user;
        await storeUserCredentials(user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return e;
        } else if (e.code == 'invalid-credential') {
          return e;
        }
      } catch (e) {
        return e;
      }
    }

    return user;
  }

  Future<void> storeUserCredentials(User? user) async {
    if (user != null) {
      InstaUser.storeUserInfoGoogleSignIn(user);

      Application.storageService?.isUserLoggedIn = true;
      Application.secureStorageService?.username =
          Future.value(InstaUser.userName);
      Application.secureStorageService?.email = Future.value(InstaUser.email);
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await firebaseAuthInstance!.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error signing out. Try again.'),
        ),
      );
    }
  }
}
