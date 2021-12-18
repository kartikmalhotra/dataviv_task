import 'package:flutter/material.dart';
import 'package:task/screens/alarm_screen.dart';
import 'package:task/screens/profile_screen.dart';
import 'package:task/screens/sport_screen.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        backgroundColor: Color(0xff7b83eb),
        scaffoldBackgroundColor: Color(0xff7b83eb),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _isDrawerOpened;
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = 0;
    _isDrawerOpened = true;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        appBar: _showAppBar(context),
        body: Container(
          child: Row(
            children: [
              _isDrawerOpened ? _showAppDrawer() : Container(),
              _showHomeScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showAppDrawer() {
    return Expanded(
      flex: 2,
      child: Container(
        padding: EdgeInsets.all(15.0),
        color: Color(0xff455797),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  InkWell(
                    onTap: () => setState(() {
                      _currentIndex = 0;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.person_outline, color: Colors.white),
                        Text(
                          "PROFILE",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () => setState(() {
                      _currentIndex = 1;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.alarm_on_rounded, color: Colors.white),
                        Text(
                          "ALARM",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  InkWell(
                    onTap: () => setState(() {
                      _currentIndex = 2;
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.rate_review, color: Colors.white),
                        Text(
                          "SPORT",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: InkWell(
                onTap: () => setState(() => _isDrawerOpened = false),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.arrow_left_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "EXIT",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showHomeScreen() {
    return Expanded(
      flex: 4,
      child: Container(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            ProfileScreen(),
            AlarmScreen(),
            SportsScreen(),
          ],
        ),
      ),
    );
  }

  AppBar _showAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xff455797),
      centerTitle: true,
      title: Text(
        "Alarm",
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white),
      ),
      leading: IconButton(
        icon: _isDrawerOpened ? Icon(Icons.close) : Icon(Icons.menu),
        onPressed: () {
          setState(() {
            _isDrawerOpened = !_isDrawerOpened;
          });
        },
      ),
    );
  }
}
