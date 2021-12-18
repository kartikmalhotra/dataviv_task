import 'package:task/config/application.dart';
import 'package:task/utils/services/rest_api_service.dart';

abstract class UserPostRepository {
  Future<dynamic> fetchPostList();
}

class UserPostRepositoryImpl extends UserPostRepository {
  @override
  Future<dynamic> fetchPostList() async {
    try {
      final response = await Application.restService!.fetchData(
          Uri.parse(
              "https://api.unsplash.com/photos/?client_id=rhom0ccDxvUFrDUpGXn93nT88BhqDhT1y5nXC34AIxY"),
          APIRequest.GET);
      return response;
    } catch (e) {
      return e;
    }
  }
}
