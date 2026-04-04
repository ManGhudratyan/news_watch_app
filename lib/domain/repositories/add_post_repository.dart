import 'package:news_watch_app/data/models/post/post_model.dart';

abstract class AddPostRepository {
  Future<void> addPosts(PostModel model);
  Future<List<PostModel>> getPosts({required String userId});
}
