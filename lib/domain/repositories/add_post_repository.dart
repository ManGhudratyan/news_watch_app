import 'package:news_watch_app/data/models/post/post_model.dart';

abstract class AddPostRepository {
  Future<void> savePost(PostModel post);
  Future<void> removeSavedPost(PostModel post);
  Future<List<PostModel>> getSavedPosts({required String userId});
  Future<bool> isPostSaved(PostModel post);
  Future<void> addPosts(PostModel model);
  Future<List<PostModel>> getPosts({required String userId});
  Future<void> likePost(PostModel post);
  Future<void> removeLikedPost(PostModel post);
  Future<List<PostModel>> getLikedPosts({required String userId});
  Future<bool> isPostLiked(PostModel post);
}
