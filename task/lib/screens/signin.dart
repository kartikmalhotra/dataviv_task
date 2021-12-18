import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/config/application.dart';
import 'package:task/config/routes/routes_const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task/widget/widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _showBackgroundImage(context),
            _displaySignInForm(context),
          ],
        ),
      ),
    );
  }

  Widget _showBackgroundImage(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: CachedNetworkImage(
          fit: BoxFit.fitHeight,
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              value: progress.progress,
              color: Colors.black,
            ),
          ),
          imageUrl:
              "https://images.unsplash.com/photo-1639351516356-8ed2dc90b4ed?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
        ),
      ),
    );
  }

  Widget _displaySignInForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInForm(),
        ],
      ),
    );
  }
}

// Define a custom Form widget.
class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return _displaySignInButton(context);
  }

  Widget _displaySignInButton(BuildContext context) {
    return AppElevatedButton(
      color: Colors.white,
      minWidth: 400,
      textColor: Colors.pinkAccent,
      message: "GOOGLE SIGNIN",
      onPressed: () => _googleSignIn(),
    );
  }

  void _googleSignIn() async {
    var response = await Application.firebaseAuthentication!.signInWithGoogle();
    if (response is! Exception) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.appScreen, (Route<dynamic> route) => false);
    } else if (response is FirebaseAuthException) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.message.toString())),
      );
    }
  }
}
