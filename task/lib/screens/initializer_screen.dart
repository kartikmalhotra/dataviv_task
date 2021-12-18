import 'package:flutter/material.dart';

class InitializerScreen extends StatelessWidget {
  const InitializerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "BWYS",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10.0),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class InitializerScreenLoader extends StatefulWidget {
  InitializerScreenLoader({Key? key}) : super(key: key);

  @override
  _InitializerScreenLoaderState createState() =>
      _InitializerScreenLoaderState();
}

class _InitializerScreenLoaderState extends State<InitializerScreenLoader> {
  @override
  void initState() {
    super.initState();
    _oneSecongDelay();
  }

  void _oneSecongDelay() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
