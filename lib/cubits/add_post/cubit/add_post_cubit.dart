// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostRepository addPostRepository;
  List<AddPostModel> posts = [];
  AddPostCubit(this.addPostRepository) : super(AddPostInitial());

  Future<void> addNewPost(AddPostModel model) async {
    emit(AddPostLoading());
    try {
      await addPostRepository.addPosts(model);
      posts = [model, ...posts];
      emit(AddPostSuccess());
      final updatedPosts = await addPostRepository.getPosts(
        userId: model.userId,
      );
      emit(AddPostLoaded(updatedPosts));
    } catch (e) {
      emit(AddPostFailure(e.toString()));
    }
  }

  Future<void> getPosts(String userId) async {
    emit(AddPostLoading());
    try {
      final updatedPosts = await addPostRepository.getPosts(userId: userId);
      emit(AddPostLoaded(updatedPosts));
    } catch (e) {
      emit(AddPostFailure(e.toString()));
    }
  }
}
