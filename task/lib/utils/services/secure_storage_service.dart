import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:task/constants/app_constants.dart';

class SecureStorageService {
  static SecureStorageService? _instance;
  static FlutterSecureStorage? _preferences;

  SecureStorageService._internal();

  static SecureStorageService? getInstance() {
    if (_instance == null) {
      _instance = SecureStorageService._internal();
    }
    if (_preferences == null) {
      _preferences = const FlutterSecureStorage();
    }

    return _instance;
  }

  Future<String> get username async =>
      await (_getDataFromSecureStorage(AppSecureStoragePreferencesKeys.username)
          as FutureOr<String>?) ??
      "";

  set username(Future<String> value) =>
      _saveDataToSecureStorage(AppSecureStoragePreferencesKeys.username, value);

  Future<String> get email async =>
      await (_getDataFromSecureStorage(AppSecureStoragePreferencesKeys.email)
          as FutureOr<String>?) ??
      "";

  set email(Future<String> value) =>
      _saveDataToSecureStorage(AppSecureStoragePreferencesKeys.username, value);

  Future<String> get authToken async =>
      await (_getDataFromSecureStorage(
          AppSecureStoragePreferencesKeys.authToken)) ??
      "";

  set authToken(Future<String> value) => _saveDataToSecureStorage(
      AppSecureStoragePreferencesKeys.authToken, value);

  Future<String?> _getDataFromSecureStorage(String key) async {
    String? value = await _preferences!.read(key: key);
    return value;
  }

  Future<void> deleteDataFromSecureStorage(String key) async {
    await _preferences!.delete(key: key);
  }

  Future<void> deleteAllDataFromSecureStorage() async {
    await _preferences!.deleteAll();
  }

  Future<void> _saveDataToSecureStorage(
      String key, Future<String> value) async {
    await _preferences!.write(key: key, value: await value);
  }
}
