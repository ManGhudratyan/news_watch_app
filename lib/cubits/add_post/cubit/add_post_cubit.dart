// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostRepository addPostRepository;
  List<AddPostModel> posts = [];
  AddPostCubit(this.addPostRepository)
    : super(const AddPostState(posts: [], loading: false));

  Future<void> addNewPost(AddPostModel model) async {
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
}
