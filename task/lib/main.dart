import 'package:firebase_core/firebase_core.dart';
import 'package:task/insta_app.dart';
import 'package:task/config/application.dart';
import 'package:task/config/routes/routes.dart';
import 'package:task/utils/services/firebase_authentication.dart';
import 'package:task/utils/services/local_storage_service.dart';
import 'package:task/utils/services/rest_api_service.dart';
import 'package:task/utils/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  await Firebase.initializeApp();
  Application.secureStorageService = SecureStorageService.getInstance();
  Application.storageService = await LocalStorageService?.getInstance();
  Application.restService = RestAPIService.getInstance();
  Application.firebaseAuthentication =
      FirebaseAuthenticationSerive.getInstance();

  Application.isDeviceAuthAvailable =
      Application.storageService!.isDeviceAuthAvailable;

  /// Store application prefered theme in the Application class
  Application.preferedTheme = Application.storageService!.themeMode;

  /// Store application language in the Application class
  Application.preferedLanguage = Application.storageService!.selectedLanguage;

  InstaUser.isUserLoggedIn = Application.storageService!.isUserLoggedIn;
  RouteSetting.getInstance();
  runApp(InstaApp());
}
