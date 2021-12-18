import 'package:flutter/foundation.dart';
import 'package:task/repository/repository.dart';
import 'dart:async';

import 'package:task/shared/models/user_post_model.dart';

class UserPostProvider extends ChangeNotifier {
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  /// Fetched Data
  dynamic _fetchedData;
  dynamic get getFetchedData => _fetchedData;

  List<UserPost> _favouratePost = [];
  List<UserPost> get favouratePost => _favouratePost;

  UserPostRepository repository;

  UserPostProvider({required this.repository});

  /// Fetch User Post
  Future<void> fetchUserPost() async {
    _isFetching = true;
    notifyListeners();

    final data = await repository.fetchPostList() ?? '';
    print(data.toString());
    if (data is! Exception) {
      _fetchedData = UserPostModel.fromJson(data);
    } else {
      _fetchedData = data;
    }
    _isFetching = false;
    notifyListeners();
  }

  /// Fetch User Post
  Future<void> fetchPostDescription() async {
    notifyListeners();

    final data = await repository.fetchPostList() ?? '';
    print(data.toString());
    if (data is! Exception) {
      _fetchedData = UserPostModel.fromJson(data);
    } else {
      _fetchedData = data;
    }
    _isFetching = false;
    notifyListeners();
  }

  void getFavouratePost() {
    notifyListeners();
  }

  /// Add Post to Favourate
  void addPostToFavourate(UserPost userPost) {
    if (userPost.isFavourate) {
      _favouratePost.add(userPost);
    } else {
      _favouratePost.removeWhere((element) => element.id == userPost.id);
    }

    notifyListeners();
  }

  /// Like The Post
  void likeThePost() {
    notifyListeners();
  }
}
