import 'dart:convert';

import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostRepositoryImp implements AddPostRepository {
  String _key(String userId) => "user_posts_$userId";

  @override
  Future<void> addPosts(AddPostModel model) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _key(model.userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    List<Map<String, dynamic>> allPosts = [];
    if (savedPostsJson != null) {
      allPosts = List<Map<String, dynamic>>.from(json.decode(savedPostsJson));
    }

    allPosts.add(model.toJson());
    await sharedPrefs.setString(key, json.encode(allPosts));
  }

  @override
  Future<List<AddPostModel>> getPosts({required String userId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _key(userId);
    final String? savedPostsJson = sharedPrefs.getString(key);
    if (savedPostsJson == null) return [];

    final List<Map<String, dynamic>> allPosts = List<Map<String, dynamic>>.from(
      json.decode(savedPostsJson),
    );

    final List<AddPostModel> userPosts = allPosts
        .map((json) => AddPostModel.fromJson(json))
        .toList();

    return userPosts.reversed.toList();
  }
}
