import 'package:news_watch_app/data/models/add_post/add_post_model.dart';

abstract class AddPostRepository {
  Future<void> addPosts(AddPostModel model);
  Future<List<AddPostModel>> getPosts({required String userId});
}
