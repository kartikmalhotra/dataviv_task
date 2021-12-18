import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/shared/models/notification_model.dart';

import 'package:task/shared/repository/user_repository.dart';
import 'package:task/utils/services/common_service.dart';
import 'package:task/utils/services/firebase_authentication.dart';
import 'package:task/utils/services/local_storage_service.dart';
import 'package:task/utils/services/rest_api_service.dart';
import 'package:task/utils/services/secure_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class Application {
  static String? preferedLanguage;
  static String? preferedTheme;
  static Brightness? hostSystemBrightness;
  static LocalStorageService? storageService;
  static SecureStorageService? secureStorageService;
  static FirebaseAuthenticationSerive? firebaseAuthentication;
  static RestAPIService? restService;
  static CommonService? commonService;
  static UserRepository? userRepository;

  static bool? isDeviceAuthAvailable;
  static List<BiometricType> enrolledBiometrics = [];

  static TargetPlatform platform =
      Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android;

  /// Variable to hold notification data temporarily when notification is tapped
  /// when app is closed, that tap will be handled after app is initialized and
  /// user has logged in
  static NotificationData? tappedNotificationData;
}

class InstaUser {
  static String? userToken;
  static String? photoUrl;
  static String? uid;
  static late bool isUserLoggedIn;
  static String? userName;
  static String? email;

  static void storeUserInfoGoogleSignIn(User user) {
    userToken = user.refreshToken;
    uid = user.uid;
    userName = user.displayName;
    email = user.email;
    photoUrl = user.photoURL;
    isUserLoggedIn = true;
  }

  static void removeAllData() {
    userName = userToken = uid = email = photoUrl = null;
    isUserLoggedIn = false;
  }
}

class Task {
  static Map<String, bool> modules = {};
}
