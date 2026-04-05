import 'dart:convert';

import 'package:news_watch_app/data/models/post/post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPostRepositoryImp implements AddPostRepository {
  String _postsKey(String userId) => "user_posts_$userId";
  String _savedPostsKey(String userId) => "saved_posts_$userId";
  String _likedPostsKey(String userId) => "liked_posts_$userId";

  @override
  Future<void> addPosts(PostModel model) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _postsKey(model.userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    List<Map<String, dynamic>> allPosts = [];
    if (savedPostsJson != null) {
      allPosts = List<Map<String, dynamic>>.from(json.decode(savedPostsJson));
    }

    allPosts.add(model.toJson());
    await sharedPrefs.setString(key, json.encode(allPosts));
  }

  @override
  Future<List<PostModel>> getPosts({required String userId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _postsKey(userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    if (savedPostsJson == null) return [];

    final List<Map<String, dynamic>> allPosts = List<Map<String, dynamic>>.from(
      json.decode(savedPostsJson),
    );

    final List<PostModel> userPosts = allPosts
        .map((json) => PostModel.fromJson(json))
        .toList();

    return userPosts.reversed.toList();
  }

  @override
  Future<void> savePost(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _savedPostsKey(post.userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    List<Map<String, dynamic>> savedPosts = [];
    if (savedPostsJson != null) {
      savedPosts = List<Map<String, dynamic>>.from(json.decode(savedPostsJson));
    }

    final alreadySaved = savedPosts.any(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );

    if (!alreadySaved) {
      savedPosts.add(post.toJson());
      await sharedPrefs.setString(key, json.encode(savedPosts));
    }
  }

  @override
  Future<void> removeSavedPost(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _savedPostsKey(post.userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    if (savedPostsJson == null) return;

    List<Map<String, dynamic>> savedPosts = List<Map<String, dynamic>>.from(
      json.decode(savedPostsJson),
    );

    savedPosts.removeWhere(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );

    await sharedPrefs.setString(key, json.encode(savedPosts));
  }

  @override
  Future<List<PostModel>> getSavedPosts({required String userId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _savedPostsKey(userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    if (savedPostsJson == null) return [];

    final List<Map<String, dynamic>> savedPosts =
        List<Map<String, dynamic>>.from(json.decode(savedPostsJson));

    return savedPosts
        .map((json) => PostModel.fromJson(json))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<bool> isPostSaved(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _savedPostsKey(post.userId);
    final String? savedPostsJson = sharedPrefs.getString(key);

    if (savedPostsJson == null) return false;

    final List<Map<String, dynamic>> savedPosts =
        List<Map<String, dynamic>>.from(json.decode(savedPostsJson));

    return savedPosts.any(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );
  }

  @override
  Future<void> likePost(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _likedPostsKey(post.userId);
    final String? likedPostsJson = sharedPrefs.getString(key);

    List<Map<String, dynamic>> likedPosts = [];
    if (likedPostsJson != null) {
      likedPosts = List<Map<String, dynamic>>.from(json.decode(likedPostsJson));
    }

    final alreadyLiked = likedPosts.any(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );

    if (!alreadyLiked) {
      likedPosts.add(post.toJson());
      await sharedPrefs.setString(key, json.encode(likedPosts));
    }
  }

  @override
  Future<void> removeLikedPost(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _likedPostsKey(post.userId);
    final String? likedPostsJson = sharedPrefs.getString(key);

    if (likedPostsJson == null) return;

    List<Map<String, dynamic>> likedPosts = List<Map<String, dynamic>>.from(
      json.decode(likedPostsJson),
    );

    likedPosts.removeWhere(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );

    await sharedPrefs.setString(key, json.encode(likedPosts));
  }

  @override
  Future<List<PostModel>> getLikedPosts({required String userId}) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _likedPostsKey(userId);
    final String? likedPostsJson = sharedPrefs.getString(key);

    if (likedPostsJson == null) return [];

    final List<Map<String, dynamic>> likedPosts =
        List<Map<String, dynamic>>.from(json.decode(likedPostsJson));

    return likedPosts
        .map((json) => PostModel.fromJson(json))
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<bool> isPostLiked(PostModel post) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final key = _likedPostsKey(post.userId);
    final String? likedPostsJson = sharedPrefs.getString(key);

    if (likedPostsJson == null) return false;

    final List<Map<String, dynamic>> likedPosts =
        List<Map<String, dynamic>>.from(json.decode(likedPostsJson));

    return likedPosts.any(
      (item) =>
          item['heading'] == post.heading &&
          item['description'] == post.description &&
          item['postCreated'] == post.postCreated?.toIso8601String(),
    );
  }
}
