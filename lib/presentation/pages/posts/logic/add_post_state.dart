part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostLoaded extends AddPostState {
  final List<AddPostModel> posts;
  AddPostLoaded(this.posts);
}

class AddPostFailure extends AddPostState {
  final String error;
  AddPostFailure(this.error);
}

class AddPostSuccess extends AddPostState {}