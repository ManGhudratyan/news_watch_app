// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/domain/repositories/add_post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  final AddPostRepository addPostRepository;
  List<AddPostModel> posts = [];
  AddPostBloc({required this.addPostRepository}) : super(AddPostInitial()) {
    on<AddNewPostEvent>(_mapAddNewPostEventToState);
    on<GetPostsEvent>(_mapGetPostsEventToState);
  }

  Future<void> _mapAddNewPostEventToState(
    AddNewPostEvent event,
    Emitter<AddPostState> emit,
  ) async {
    emit(AddPostLoading());
    try {
      await addPostRepository.addPosts(event.model);
      posts = [event.model, ...posts];
      emit(AddPostSuccess());
      final updatedPosts = await addPostRepository.getPosts(
        userId: event.model.userId,
      );
      emit(AddPostLoaded(updatedPosts));
    } catch (e) {
      emit(AddPostFailure(e.toString()));
    }
  }

  FutureOr<void> _mapGetPostsEventToState(
    GetPostsEvent event,
    Emitter<AddPostState> emit,
  ) async {
    emit(AddPostLoading());
    try {
      final updatedPosts = await addPostRepository.getPosts(
        userId: event.userId,
      );
      emit(AddPostLoaded(updatedPosts));
    } catch (e) {
      emit(AddPostFailure(e.toString()));
    }
  }
}
