import 'dart:convert';

import 'package:http/http.dart' as https;

class RestAPIService {
  static RestAPIService? instance;
  static String? _appBaseUrl;
  static String? apiKey;

  RestAPIService._internal();

  static RestAPIService getInstance() {
    if (instance == null) {
      instance = RestAPIService._internal();
    }
    if (_appBaseUrl == null) {
      _appBaseUrl = 'http://api.weatherapi.com/v1';
    }
    if (apiKey == null) {
      apiKey = '75c9266486ce4e2593355224211011';
    }
    return instance!;
  }

  Future<dynamic> fetchData(Uri uri, APIRequest apiRequest,
      {Map<String, String>? headerParams,
      Map<String, dynamic>? replaceParam}) async {
    switch (apiRequest) {
      case APIRequest.GET:
        var data = await https.get(uri);
        return checkResponseStatus(data);
      case APIRequest.PUT:
      case APIRequest.FETCH:
      case APIRequest.DELETE:
      case APIRequest.PATCH:
      default:
    }
  }

  dynamic checkResponseStatus(https.Response data) {
    switch (data.statusCode) {
      case 200:
        return {'data': json.decode(data.body)};
      case 201:
      case 400:
        return RestAPIException(code: 1000, message: 'Unexpected Error');
    }
  }
}

class RestAPIException {
  int code;
  String message;

  RestAPIException({required this.code, required this.message});
}

enum APIRequest { GET, PUT, FETCH, DELETE, PATCH }
