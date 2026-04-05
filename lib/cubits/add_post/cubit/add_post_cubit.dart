// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:news_watch_app/data/models/post/post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';
import 'package:share_plus/share_plus.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostRepository addPostRepository;
  List<PostModel> posts = [];
  List<PostModel> savedPosts = [];
  AddPostCubit(this.addPostRepository)
    : super(const AddPostState(posts: [], loading: false, savedPosts: []));

  Future<void> addNewPost(PostModel model) async {
    emit(state.copyWith(loading: true));
    try {
      await addPostRepository.addPosts(model);
      final updatedPosts = await addPostRepository.getPosts(
        userId: model.userId,
      );
      posts = updatedPosts;
      emit(state.copyWith(posts: posts, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> getPosts(String userId) async {
    emit(state.copyWith(loading: true));
    try {
      final updatedPosts = await addPostRepository.getPosts(userId: userId);
      posts = updatedPosts;
      emit(state.copyWith(posts: posts, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> sharePost(PostModel post) async {
    try {
      final String shareText =
          '${post.heading ?? 'News Post'}\n\n${post.description ?? ''}';

      if (post.imagePath != null && post.imagePath!.isNotEmpty) {
        await SharePlus.instance.share(
          ShareParams(
            title: post.heading ?? 'Share Post',
            text: shareText,
            files: [XFile(post.imagePath!)],
          ),
        );
      } else {
        await SharePlus.instance.share(
          ShareParams(title: post.heading ?? 'Share Post', text: shareText),
        );
      }
    } catch (e) {
      debugPrint('Share failed: $e');
    }
  }

  Future<void> savePost(PostModel post) async {
    await addPostRepository.savePost(post);
    final savedPosts = await addPostRepository.getSavedPosts(
      userId: post.userId,
    );
    emit(state.copyWith(savedPosts: savedPosts));
  }

  Future<void> removeSavedPost(PostModel post) async {
    await addPostRepository.removeSavedPost(post);
    final savedPosts = await addPostRepository.getSavedPosts(
      userId: post.userId,
    );
    emit(state.copyWith(savedPosts: savedPosts));
  }

  Future<void> getSavedPosts(String userId) async {
    final savedPosts = await addPostRepository.getSavedPosts(userId: userId);
    emit(state.copyWith(savedPosts: savedPosts));
  }

  Future<void> toggleSavedPost(PostModel post) async {
    final isSaved = await addPostRepository.isPostSaved(post);

    if (isSaved) {
      await addPostRepository.removeSavedPost(post);
    } else {
      await addPostRepository.savePost(post);
    }

    final savedPosts = await addPostRepository.getSavedPosts(
      userId: post.userId,
    );
    emit(state.copyWith(savedPosts: savedPosts));
  }

  Future<bool> submitPost({
  required String heading,
  required String description,
  required String category,
  required String userId,
  String? imagePath,
  String? tag,
  String? username,
}) async {
  if (heading.trim().isEmpty || description.trim().isEmpty) {
    return false;
  }

  emit(state.copyWith(loading: true));

  try {
    final model = PostModel(
      heading: heading.trim(),
      tag: tag?.trim(),
      category: category,
      description: description.trim(),
      imagePath: imagePath,
      userId: userId,
      username: username,
      postCreated: DateTime.now(),
    );

    await addPostRepository.addPosts(model);
    final updatedPosts = await addPostRepository.getPosts(userId: userId);

    emit(state.copyWith(posts: updatedPosts, loading: false));
    return true;
  } catch (e) {
    emit(state.copyWith(loading: false));
    return false;
  }
}
}
