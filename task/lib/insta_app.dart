import 'package:provider/provider.dart';
import 'package:task/config/screen_config.dart';
import 'package:task/config/themes/light_theme.dart';

import 'package:flutter/material.dart';
import 'package:task/screens/favourate.dart';
import 'package:task/repository/repository.dart';
import 'package:task/screens/home_screen.dart';
import 'package:task/screens/profile_screen.dart';

import 'config/routes/routes.dart';
import 'providers/user_post_provider.dart';

class InstaApp extends StatelessWidget {
  const InstaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserPostProvider>(
      create: (_) => UserPostProvider(
        repository: UserPostRepositoryImpl(),
      ),
      child: MaterialApp(
        theme: lightThemeData['themeData'] as ThemeData,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteSetting.generateRoute,
      ),
    );
  }
}

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SetAppScreenConfiguration.init(context);

    return Scaffold(
      backgroundColor: LightAppColors.cardBackground,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(),
            FavourateScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black87),
        selectedItemColor: Colors.black87,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite '),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
